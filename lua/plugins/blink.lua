-- completion
return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
            {
                "saghen/blink.compat",
                version = not vim.g.lazyvim_blink_main and "*",
            },
        },
        opts = {
            completion = {
                ghost_text = { enabled = true },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    -- show documentation immediately
                    auto_show_delay_ms = 0,
                },
            },
            sources = {
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
                default = { "lsp", "path", "snippets", "buffer" },
            },
            keymap = {
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
            },
        },
        config = function(_, opts)
            require("blink.cmp").setup(opts)

            -- Extend neovim's client capabilities with the completion ones.
            vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
        end,
    },
}
