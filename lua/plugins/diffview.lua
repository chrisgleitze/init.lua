return {
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- require("diffview").setup(),
    config = function()
        vim.keymap.set("n", "<leader>V", function()
            if next(require("diffview.lib").views) == nil then
                vim.cmd("DiffviewOpen")
            else
                vim.cmd("DiffviewClose")
            end
        end)
    end,
}
