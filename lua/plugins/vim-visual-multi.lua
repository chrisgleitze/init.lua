return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  config = function()
    vim.keymap.set("n", "<C-x>", "<Plug>(VM-Find-Under)")
  end,
}
