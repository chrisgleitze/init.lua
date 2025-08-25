return {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
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
                -- border = "rounded",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "rounded",
                },
            },
        },
        sources = {
            -- adding any nvim-cmp sources here will enable them
            -- with blink.compat
            default = { "lsp", "path", "snippets", "buffer" },
        },
        keymap = {
            preset = "default",
            -- ["<C-y>"] = { "select_and_accept" },
            ["<CR>"] = { "select_and_accept", "fallback" },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },

            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            -- ["<CR>"] = { "accept", "fallback" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-e>"] = { "hide", "fallback" },
        },
    },
}
