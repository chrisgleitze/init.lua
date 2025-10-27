return {
    "tpope/vim-fugitive",
    config = function()
        local map = vim.keymap.set
        map("n", "<leader>Gi", "<cmd>Git <CR>")
        map("n", "<leader>Gb", "<cmd>Git blame<CR>")
        map("n", "<leader>Gl", "<cmd>Git log<CR>")
        map("n", "<leader>Gs", "<cmd>Git status<CR>")
        map("n", "<leader>Gd", "<cmd>Git diff<CR>")
        map("n", "<leader>D", ":Git<CR><C-w><C-o>:bd<CR>")
    end,
}
