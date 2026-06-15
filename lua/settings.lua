local o = vim.opt

-- General
o.backup = false
o.clipboard = 'unnamedplus'
o.guicursor = ''
o.hidden = true
o.linebreak = true
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.scrolloffpad = 1
o.swapfile = false
o.termguicolors = true
o.undofile = true
o.shada = {
    '!',
    "'100",
    '<50',
    's10',
    'h',
    'r/tmp/',
    'r/private/',
}
o.sessionoptions = {
    'buffers',
    'curdir',
    'folds',
    'help',
    'tabpages',
    'winsize',
}

-- important for performance
o.timeout = true -- don't wait indefinitely for mapped keys
o.timeoutlen = 400
o.ttimeoutlen = 50 -- timeout for key codes
o.updatetime = 300

-- Editing
o.autoindent = true
o.expandtab = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.shiftwidth = 4
o.tabstop = 4
o.virtualedit = 'block'

-- UI
o.cursorline = false
o.cmdheight = 1
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.winborder = 'single'
