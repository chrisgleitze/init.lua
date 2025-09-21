-- minimal Neovim config
vim.g.mapleader = " "
vim.o.undofile      = true
vim.o.clipboard     = "unnamedplus"
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = -1
vim.cmd("syntax on | colorscheme retrobox | highlight Normal guifg=#ffaf00 guibg=#282828")
