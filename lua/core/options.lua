vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- hidden buffers are not displayed but loaded in memory
vim.opt.hidden = true

-- set absolute number for current line, relative numbers for all other lines
vim.opt.nu = true
vim.opt.rnu = true

-- creation of swapfiles and backup files
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

-- highlight search, incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.diagnostic.enable(true)

vim.opt.cursorline = false

vim.opt.guicursor = "n-v-ve-o-r-c-cr-sm:block-blinkwait175,i-ci:ver25-blinkwait175"
