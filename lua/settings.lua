local o = vim.opt

-- general
o.backup = false
o.clipboard = ''
o.guicursor = ''
o.hidden = true
o.linebreak = true
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.scrolloff = 10
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

-- wsl clipboard provider
local wsl_copy = { 'sh', '-c', 'iconv -f UTF-8 -t UTF-16LE | /mnt/c/Windows/System32/clip.exe' }
local wsl_paste = {
    '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe',
    '-NoLogo',
    '-NoProfile',
    '-Command',
    '$text = Get-Clipboard -Raw -Format Text -ErrorAction SilentlyContinue; [Console]::OutputEncoding=[Text.UTF8Encoding]::new(); if ($null -ne $text) { [Console]::Out.Write($text.Replace("`r", "")) }',
}
vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
        ['+'] = wsl_copy,
        ['*'] = wsl_copy,
    },
    paste = {
        ['+'] = wsl_paste,
        ['*'] = wsl_paste,
    },
    cache_enabled = 0,
}

-- important for performance
o.timeout = true -- don't wait indefinitely for mapped keys
o.timeoutlen = 400
o.ttimeoutlen = 50 -- timeout for key codes
o.updatetime = 300

-- editing
o.autoindent = true
o.autoread = true
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

o.statusline = " %{get(b:,'gitsigns_head','')} %f%m%r%=%{&filetype} %l:%c "
o.winborder = 'single'
o.pumborder = 'single'
