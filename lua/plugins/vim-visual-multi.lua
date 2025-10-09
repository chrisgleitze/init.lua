return {
    "mg979/vim-visual-multi",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    config = function()
        vim.keymap.set("n", "<C-x>", "<Plug>(VM-Find-Under)")
    end,
}
