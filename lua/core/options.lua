-- set space leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- hidden buffers are not displayed but loaded in memory
vim.opt.hidden = true

-- set absolute [nu]mber for current line, [r]elative [nu]mbers for all other lines
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- creation of swapfiles and backup files
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
-- location for shada, persistent undo etc.
-- changed from .local/share to .local/state
-- vim.opt.undodir = "~/.local/state/nvim/undo/"

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

-- highlight search, incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.diagnostic.enable(true)

vim.opt.cursorline = false

-- vim.opt.guicursor = ""
vim.opt.guicursor = "n-v-ve-o-r-c-cr-sm:block-blinkwait175,i-ci:ver25-blinkwait175"
