local o = vim.opt

-- General =====================
o.backup = false -- don't store backup
o.hidden = true -- load hidden buffers in memory
o.mouse = "a" -- enable mouse
o.nu = true -- set absolute [nu]mber for current line
o.rnu = true -- [r]elative [nu]mbers for all other lines
o.scrolloff = 10 -- always leave this number of lines above and below the cursor
o.swapfile = false -- don't create swapfile
o.undofile = true -- enable persistent undo

-- update times and timeouts; important for performance
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10

-- Editing =====================
o.autoindent = true -- use auto indent
o.incsearch = true -- incremental search
o.hlsearch = true -- highlight search
o.expandtab = true -- tab key inserts space characters
o.tabstop = 4 -- insert 2 spaces for a tab
o.shiftwidth = 4 -- use this number of spaces for indentation
o.virtualedit = "block" -- allow going past the end of line in visual block mode

-- UI ==========================
o.cursorline = false -- no visual cursor line
-- o.guicursor = "n-v-ve-o-r-c-cr-sm:block-blinkwait175,i-ci:ver25-blinkwait175"
o.cmdheight = 1 -- more space in the neovim command line to display messages
o.signcolumn = "yes" -- always show signcolumn
o.splitbelow = true -- horizontal splits will be below
o.splitright = true -- vertical splits will be to the right
