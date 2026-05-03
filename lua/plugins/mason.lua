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
            local function prefer_wsl_node()
                if vim.fn.has('wsl') ~= 1 then
                    return
                end

                local nvm_bins = vim.fn.glob(vim.env.HOME .. '/.nvm/versions/node/*/bin', false, true)
                table.sort(nvm_bins, function(a, b)
                    local function version(path)
                        local major, minor, patch = path:match('/v(%d+)%.(%d+)%.(%d+)/bin$')
                        return tonumber(major) or 0, tonumber(minor) or 0, tonumber(patch) or 0
                    end

                    local a_major, a_minor, a_patch = version(a)
                    local b_major, b_minor, b_patch = version(b)

                    if a_major ~= b_major then
                        return a_major > b_major
                    end
                    if a_minor ~= b_minor then
                        return a_minor > b_minor
                    end
                    return a_patch > b_patch
                end)

                for _, bin in ipairs(nvm_bins) do
                    if vim.fn.executable(bin .. '/npm') == 1 then
                        vim.env.PATH = bin .. ':' .. vim.env.PATH
                        return
                    end
                end
            end

            prefer_wsl_node()

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
