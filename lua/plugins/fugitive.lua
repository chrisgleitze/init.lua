return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>G", "<cmd>Git <CR>")
        vim.keymap.set("n", "<leader>Gb", "<cmd>Git blame<CR>")
    end,
}
