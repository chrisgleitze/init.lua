return {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>" },
        { "<leader>gB", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>" },
        -- open and close diffview
        vim.keymap.set("n", "<leader>V", function()
            if next(require("diffview.lib").views) == nil then
                vim.cmd("DiffviewOpen")
            else
                vim.cmd("DiffviewClose")
            end
        end),
    },
    config = function()
        local actions = require("diffview.actions")

        require("diffview").setup({
            enhanced_diff_hl = true,
            use_icons = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
            },
            file_panel = {
                listing_style = "tree",
                win_config = {
                    position = "left",
                    width = 35,
                },
            },
            keymaps = {
                view = {
                    { "n", "q", actions.close, { desc = "Close help menu" } },
                },
                file_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
                },
                file_history_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
                },
            },
        })
    end,
}
