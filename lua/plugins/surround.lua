return {
    "echasnovski/mini.surround",
    recommended = true,
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        mappings = {
            add = "ys", -- Add surrounding in Normal and Visual modes
            delete = "ds", -- Delete surrounding
            find = "", -- Find surrounding (disabled)
            find_left = "", -- Find surrounding to the left (disabled)
            highlight = "", -- Highlight surrounding (disabled)
            replace = "cs", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines` (disabled)
            suffix_last = "", -- Disabled

            suffix_next = "", -- Disabled
        },
        search_method = "cover_or_next",
    },
    config = function(_, opts)
        require("mini.surround").setup(opts)

        -- Remap adding surrounding to Visual mode selection
        vim.keymap.del("x", "ys")
        vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

        -- Make special mapping for "add surrounding for line"
        vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
}
