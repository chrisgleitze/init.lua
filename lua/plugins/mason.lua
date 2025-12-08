return {
    {
        -- turns TypeScript erros into plain English
        "dmmulroy/ts-error-translator.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("ts-error-translator").setup()
        end,
    },
    {
        -- Mason, package manager for LSPs, linters, formatters etc.
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
                    -- "bashls",
                    -- "cssls",
                    -- "clangd",
                    -- "emmet_ls",
                    -- "html",
                    -- "intelephense",
                    "lua_ls@3.15.0",
                    -- "phpactor",
                    -- "rust_analyzer",
                    -- "ts_ls",
                    -- "tailwindcss",
                },
                automatic_enable = {
                    -- it's possible that LSPs are loaded twice into the buffer by default
                    -- due to recent changes to mason-lspconfig;
                    -- exclude the redundancies here, so only my own lsp-configs are loaded
                    exclude = {
                        "bashls",
                        "clangd",
                        "jdtls",
                        "phpactor",
                    },
                },
            })

            -- install tools not included in Mason
            mason_tool_installer.setup({
                ensure_installed = {
                    "bash-language-server",
                    "eslint_d", -- JavaScript linter
                    "phpstan", -- PHP code analysis tool
                    "prettier", -- Prettier formatter
                    "shfmt", -- Shell formatter
                    "stylua", -- Lua formatter
                },
                auto_update = false,
                run_on_start = true,
                start_delay = 0,
                integrations = {
                    ["mason-lspconfig"] = true,
                    ["mason-null-ls"] = true,
                    ["mason-nvim-dap"] = true,
                },
            })
        end,
    },
}
