-- General =====================
vim.g.mapleader = " " -- set space key as leader key
vim.g.mapllocalleader = " " -- set space key as local leader key
vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1 -- disable netrw
vim.o.backup = false -- don't store backup
vim.o.hidden = true -- load hidden buffers in memory
vim.o.mouse = "a" -- enable mouse
vim.o.nu = true -- set absolute [nu]mber for current line
vim.o.rnu = true -- [r]elative [nu]mbers for all other lines
vim.o.scrolloff = 10 -- always leave this number of lines above and below the cursor
vim.o.swapfile = false -- don't create swapfile
vim.o.undofile = true -- enable persistent undo
vim.diagnostic.enable(true) -- enable diagnostic by default

-- Editing =====================
vim.o.autoindent = true -- use auto indent
vim.o.incsearch = true -- incremental search
vim.o.hlsearch = true -- highlight search
vim.o.shiftwidth = 2 -- use this number of spaces for indentation
vim.o.tabstop = 4 -- insert 2 spaces for a tab
vim.o.virtualedit = "block" -- allow going past the end of line in visual block mode

-- UI ==========================
vim.o.cursorline = false -- no visual cursor line
-- vim.o.guicursor = "n-v-ve-o-r-c-cr-sm:block-blinkwait175,i-ci:ver25-blinkwait175"
vim.o.cmdheight = 1 -- more space in the neovim command line to display messages
vim.o.signcolumn = "yes" -- always show signcolumn
vim.o.splitbelow = true -- horizontal splits will be below
vim.o.splitright = true -- vertical splits will be to the right
