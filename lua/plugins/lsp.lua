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
                    -- exclude the redundancies here, so only the lsp-configs below are loaded
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
            -- import lspconfig plugin
            -- local lspconfig = require("lspconfig")

            -- import mason_lspconfig plugin
            -- local mason_lspconfig = require("mason-lspconfig")

            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- enable autocompletion, assigned to every lsp server config
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- enabled for all lsp configs
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.lsp.config(bashls, {
                cmd = { "bash-language-server", "start" },
                filetypes = { "bash", "sh" },
                root_markers = { ".git" },
            })

            vim.lsp.config(cssls, {
                cmd = {
                    "vscode-css-language-server",
                    "--stdio",
                },
                filetypes = {
                    "css",
                    "scss",
                    "less",
                },
                init_options = {
                    provideFormatter = true, -- needed to enable formatting capabilities
                },
                root_markers = {
                    "package.json",
                    ".git",
                },
                settings = {
                    css = { validate = true },
                    scss = { validate = true },
                    less = { validate = true },
                },
            })

            vim.lsp.config(bashls, {
                capabilities = {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = true,
                            },
                        },
                    },
                },
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_markers = {
                    ".clangd",
                    ".clang-tidy",
                    ".clang-format",
                    "compile_commands.json",
                    "compile_flags.txt",
                    "configure.ac", -- AutoTools
                    ".git",
                },
            })

            vim.lsp.config(emmet_ls, {
                cmd = { "emmet-ls", "--stdio" },
                filetypes = {
                    "astro",
                    "css",
                    "eruby",
                    "html",
                    "htmlangular",
                    "htmldjango",
                    "javascriptreact",
                    "less",
                    "pug",
                    "sass",
                    "scss",
                    "svelte",
                    "templ",
                    "typescriptreact",
                    "vue",
                },
                root_markers = { ".git" },
            })

            vim.lsp.config(html, {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html", "templ" },
                init_options = {
                    provideFormatter = true,
                    embeddedLanguages = { css = true, javascript = true },
                    configurationSection = { "html", "css", "javascript" },
                },
                root_markers = { "package.json", ".git" },
            })

            vim.lsp.config(phpactor, {
                cmd = { "phpactor", "language-server" },
                filetypes = {
                    "php",
                },
                root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
                workspace_required = true,
                -- init_options = {
                --     ["language_server_phpstan.enabled"] = true,
                --     -- ["language_server_psalm.enabled"] = true,
                -- },
            })

            vim.lsp.config(tailwindcss, {
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = {
                    "css",
                    "sass",
                    "scss",
                    "less",
                    "html",
                    "htmlangular",
                    "javascript",
                    "javascriptreact",
                    "markdown",
                    "mdx",
                    "php",
                    "svelte",
                    "typescript",
                    "typescriptreact",
                    "vue",
                },
                root_markers = {
                    -- Generic
                    "tailwind.config.js",
                    "tailwind.config.cjs",
                    "tailwind.config.mjs",
                    "tailwind.config.ts",
                    "postcss.config.js",
                    "postcss.config.cjs",
                    "postcss.config.mjs",
                    "postcss.config.ts",
                    -- Django
                    "theme/static_src/tailwind.config.js",
                    "theme/static_src/tailwind.config.cjs",
                    "theme/static_src/tailwind.config.mjs",
                    "theme/static_src/tailwind.config.ts",
                    "theme/static_src/postcss.config.js",
                    -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
                    ".git",
                },
            })

            vim.lsp.config(ts_ls, {
                cmd = { "typescript-language-server", "--stdio" },
                init_options = {
                    enable = true,
                    lint = true,
                },
                filetypes = {
                    "vue",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescriptreact",
                    "typescript.tsx",
                },
                root_markers = {
                    "package-lock.json",
                    "yarn.lock",
                    "pnpm-lock.yaml",
                    "bun.lockb",
                    "bun.lock",
                    "deno.lock",
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

    -- turns TypeScript erros into plain English
    {
        "dmmulroy/ts-error-translator.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("ts-error-translator").setup()
        end,
    },
}
