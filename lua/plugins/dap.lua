-- debugger
return {
    'mfussenegger/nvim-dap',
    keys = {
        { '<leader>dv', '<cmd>DapViewToggle<cr>' },
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
        },
        {
            '<leader>dc',
            function()
                require('dap').continue()
            end,
        },
        {
            '<leader>di',
            function()
                require('dap').step_into()
            end,
        },
        {
            '<leader>do',
            function()
                require('dap').step_over()
            end,
        },
        {
            '<leader>da',
            function()
                require('dap').step_back()
            end,
        },
        {
            '<leader>du',
            function()
                require('dap').step_out()
            end,
        },
        {
            '<leader>dr',
            function()
                require('dap').restart()
            end,
        },
        {
            '<leader>dx',
            function()
                require('dap').terminate()
            end,
        },
        {
            '<leader>df',
            function()
                require('fzf-lua').dap_breakpoints()
            end,
        },
        {
            '<leader>B',
            function()
                require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end,
        },
    },
    dependencies = {
        {
            'igorlfs/nvim-dap-view',
            ---@module 'dap-view'
            ---@type dapview.Config
            opts = {
                auto_toggle = true,
                virtual_text = {
                    enabled = true,
                    position = 'eol',
                },
            },
        },
        {
            'jbyuki/one-small-step-for-vimkind', -- "osv", Lua adapter
            keys = {
                {
                    '<leader>dl',
                    function()
                        require('osv').launch({ port = 8086 })
                    end,
                    desc = 'Launch Lua adapter',
                },
            },
        },
    },
    config = function()
        local dap = require('dap')
        dap.set_log_level('WARN')

        -- Lua
        -- plugin: one-small-step-for-vimkind
        dap.adapters.nlua = function(callback, config) -- nlua: Neovim Lua
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
    end,
}
