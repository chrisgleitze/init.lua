-- LSP
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
                    "bashls",
                    "cssls",
                    "clangd",
                    "emmet_ls",
                    "html",
                    "intelephense",
                    "lua_ls",
                    "phpactor",
                    "rust_analyzer",
                    "ts_ls",
                    "tailwindcss",
                },
                automatic_enable = {
                    -- it's possible that LSPs are loaded twice into the buffer by default
                    -- due to recent changes to mason-lspconfig;
                    -- exclude the redundancies here, so only my own lsp-configs are loaded
                    exclude = {
                        "bashls",
                        "clangd",
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

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- enable autocompletion, assigned to every lsp server config
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- show diagnostic for line under cursor
            -- enabled for all lsp configs
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- diagnostic keymaps
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float(nil, { border = "rounded" })
            end)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ float = { border = "rounded" }, count = -1 })
            end)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ float = { border = "rounded" }, count = 1 })
            end)

            -- disable and enable diagnostics in current buffer
            local function hide_diagnostics()
                vim.diagnostic.config({
                    virtual_text = false,
                    signs = true,
                    underline = false,
                })
            end
            local function show_diagnostics()
                vim.diagnostic.config({
                    virtual_text = true,
                    signs = true,
                    underline = true,
                })
            end
            vim.keymap.set("n", "<leader>dh", hide_diagnostics)
            vim.keymap.set("n", "<leader>ds", show_diagnostics)

            -- diagnostic visuals
            vim.diagnostic.config({
                virtual_text = {
                    enabled = true,
                    prefix = function(diagnostic)
                        if diagnostic.severity == vim.diagnostic.severity.ERROR then
                            return "🭰× "
                        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                            return "🭰▲ "
                        else
                            return "🭰• "
                        end
                    end,
                    suffix = "🭵",
                },
                underline = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ×",
                        [vim.diagnostic.severity.WARN] = " ▲",
                        [vim.diagnostic.severity.HINT] = " •",
                        [vim.diagnostic.severity.INFO] = " •",
                    },
                },
            })

            -- enable lsp servers; find lsp server configs in /lsp folder
            vim.lsp.enable("bashls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("cssls")
            vim.lsp.enable("emmet_ls")
            vim.lsp.enable("html")
            vim.lsp.enable("phpactor")
            vim.lsp.enable("tailwindcss")
            vim.lsp.enable("ts_ls")
        end,
    },

    -- turns TypeScript erros into plain English
    {
        "dmmulroy/ts-error-translator.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("ts-error-translator").setup()
        end,
    },
}
