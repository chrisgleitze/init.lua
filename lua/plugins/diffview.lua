return {
    "sindrets/diffview.nvim",
    lazy = true,
    keys = {
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>" },
        { "<leader>gB", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>" },
        -- keymap to quickly open and close diffview
        vim.keymap.set("n", "<leader>V", function()
            if next(require("diffview.lib").views) == nil then
                vim.cmd("DiffviewOpen")
            else
                vim.cmd("DiffviewClose")
            end
        end),
    },
}
