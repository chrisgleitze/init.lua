local o = vim.opt

-- files
o.swapfile = false
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

-- timing
o.timeoutlen = 400 -- wait for mapped key sequences
o.updatetime = 300 -- CursorHold, lsp highlights, gitsigns

-- editing
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.virtualedit = 'block'

-- search
o.ignorecase = true

-- UI
o.cursorline = false
o.guicursor = ''
o.linebreak = true
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.statusline = " %{get(b:,'gitsigns_head','')} %f%m%r%=%{&filetype} %l:%c "
o.winborder = 'single'
o.pumborder = 'single'

-- clipboard: yanks stay in vim's registers, "+ and "* go through this wsl provider
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
