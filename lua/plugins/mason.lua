return {
    {
        -- turns TypeScript erros into plain English
        'dmmulroy/ts-error-translator.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('ts-error-translator').setup()
        end,
    },
    {
        -- Mason, package manager for LSPs, linters, formatters etc.
        'williamboman/mason.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            -- import mason
            local mason = require('mason')

            -- import mason-lspconfig
            local mason_lspconfig = require('mason-lspconfig')

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    'bashls',
                    'clangd',
                    'cssls',
                    'html',
                    'intelephense',
                    'lua_ls',
                    -- 'prettier',
                    'phpactor',
                    'stylua',
                    'tsgo',
                    -- 'ts_ls',
                    'tailwindcss',
                },
                automatic_enable = {
                    -- it's possible that LSPs are loaded twice into the buffer by default
                    -- due to recent changes to mason-lspconfig;
                    -- exclude the redundancies here, so only my own lsp-configs are loaded
                    exclude = {
                        'bashls',
                        'clangd',
                        'jdtls',
                        'phpactor',
                    },
                },
            })
        end,
    },
}
