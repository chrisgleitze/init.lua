return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
        },
        preview_config = { border = "rounded" },
        on_attach = function()
            local gs = require("gitsigns")

            local function map(lhs, rhs)
                vim.keymap.set("n", lhs, rhs)
            end

            map("<leader>gsb", gs.blame)
            map("<leader>gsl", gs.blame_line)
            map("<leader>gsh", gs.preview_hunk)
            map("<leader>gsi", gs.preview_hunk_inline)
        end,
    },
}
