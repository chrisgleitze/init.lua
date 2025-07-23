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

            -- show diagnostic for line under cursor
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
        end,
    },
}
