-- Debugger
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
            opts = {},
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
        {
            -- adds virtual text in debugging session
            'theHamsta/nvim-dap-virtual-text',
            opts = { virt_text_pos = 'eol' },
        },
    },
    config = function()
        local dap = require('dap')
        dap.set_log_level('WARN')

        -- opens UI when starting a new debug session
        local dv = require('dap-view')
        dap.listeners.before.attach['dap-view-config'] = function()
            dv.open()
        end
        dap.listeners.before.launch['dap-view-config'] = function()
            dv.open()
        end
        dap.listeners.before.event_terminated['dap-view-config'] = function()
            dv.close()
        end
        dap.listeners.before.event_exited['dap-view-config'] = function()
            dv.close()
        end

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

        -- JavaScript
        -- github.com/microsoft/vscode-js-debug
        require('dap').adapters['pwa-node'] = {
            -- dap.adapters.pwa-node = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
                command = 'node',
                args = { 'home/chris/js-debug/src/dapDebugServer.js', '${port}' },
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
