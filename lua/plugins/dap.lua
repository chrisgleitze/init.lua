local loader = require('plugin_loader')
local configured = false

local function configure()
    if configured then
        return require('dap')
    end

    local dap = require('dap')
    dap.set_log_level('WARN')

    ---@module 'dap-view'
    ---@type dapview.Config
    local dap_view_opts = {
        auto_toggle = true,
        virtual_text = {
            enabled = true,
            position = 'eol',
        },
    }
    require('dap-view').setup(dap_view_opts)

    -- Lua
    -- plugin: one-small-step-for-vimkind
    dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
    end
    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = 'Attach to running Neovim instance',
        },
    }

    -- C, C++, Rust
    -- github.com/vadimcn/codelldb
    dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',
    }
    dap.configurations.cpp = {
        {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- Python
    -- github.com/microsoft/debugpy
    local function python_path()
        local venv = vim.fn.getcwd() .. '/.venv/bin/python'
        if vim.fn.executable(venv) == 1 then
            return venv
        end
        return 'python3'
    end

    dap.adapters.python = {
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
        args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
            pythonPath = python_path,
        },
        {
            type = 'python',
            request = 'attach',
            name = 'Attach localhost:5678',
            connect = { host = '127.0.0.1', port = 5678 },
            pythonPath = python_path,
        },
    }

    -- Javascript
    -- github.com/microsoft/vscode-js-debug
    dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
            command = 'node',
            args = { vim.fn.expand('~/js-debug/src/dapDebugServer.js'), '${port}' },
        },
    }
    dap.configurations.javascript = {
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
        },
    }

    configured = true
    return dap
end

local function dap()
    loader.load('dap', configure)
    return require('dap')
end

loader.on_command('dap', 'Dap*', configure)

vim.api.nvim_create_autocmd('SessionLoadPost', {
    group = vim.api.nvim_create_augroup('cg/lazy_dap_session', { clear = true }),
    once = true,
    callback = function()
        if loader.is_loaded('dap') then
            return
        end
        dap()
        require('dap-view.vim-sessions').load_session_hook()
    end,
})

vim.keymap.set('n', '<leader>dv', function()
    dap()
    vim.cmd.DapViewToggle()
end)
vim.keymap.set('n', '<leader>db', function()
    dap().toggle_breakpoint()
end)
vim.keymap.set('n', '<leader>dc', function()
    dap().continue()
end)
vim.keymap.set('n', '<leader>di', function()
    dap().step_into()
end)
vim.keymap.set('n', '<leader>do', function()
    dap().step_over()
end)
vim.keymap.set('n', '<leader>da', function()
    dap().step_back()
end)
vim.keymap.set('n', '<leader>du', function()
    dap().step_out()
end)
vim.keymap.set('n', '<leader>dr', function()
    dap().restart()
end)
vim.keymap.set('n', '<leader>dx', function()
    dap().terminate()
end)
vim.keymap.set('n', '<leader>df', function()
    dap()
    require('plugins.fzf-lua')
    require('fzf-lua').dap_breakpoints()
end)
vim.keymap.set('n', '<leader>B', function()
    dap().set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dl', function()
    dap()
    require('osv').launch({ port = 8086 })
end, { desc = 'Launch Lua adapter' })
