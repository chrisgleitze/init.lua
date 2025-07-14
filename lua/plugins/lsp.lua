return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            -- import mason-tool-installer
            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "cssls",
                    "html",
                    "emmet_ls",
                    "lua_ls",
                    "ts_ls",
                    "tailwindcss",
                },
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "eslint_d", -- JavaScript linter
                    "prettier", -- Prettier formatter
                    "stylua", -- Lua formatter
                },
                auto_update = false,
                run_on_start = true,
                integrations = {
                    ["mason-lspconfig"] = true,
                    ["mason-null-ls"] = true,
                    ["mason-nvim-dap"] = true,
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- import lspconfig plugin
            local lspconfig = require("lspconfig")

            -- import mason_lspconfig plugin
            local mason_lspconfig = require("mason-lspconfig")

            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- enable autocompletion, assigned to every lsp server config
            local capabilities = cmp_nvim_lsp.default_capabilities()

            lspconfig.html.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "html" },
            })

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                init_options = {
                    enable = true,
                    lint = true,
                },
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    -- "javascript",
                    "typescript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescriptreact",
                    "typescript.tsx",
                },
            })

            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "css",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "less",
                    "sass",
                    "scss",
                    "typescriptreact",
                },
            })
        end,
    },
}
