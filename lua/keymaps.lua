local map = vim.keymap.set

-- Esc also clears search highlighting and stops snippet session
map({ 'n', 'i', 's', 'v' }, '<esc>', '<cmd>noh<cr><esc>')

-- open Lazy.nvim plugin manager
map('n', '<leader>L', '<cmd>Lazy<cr>')

-- open Mason
map('n', '<leader>Ma', '<cmd>Mason<cr>')

-- write buffer in normal
map('n', '<C-s>', function()
    vim.cmd('write')
    print('buffer saved')
end)
-- and in insert mode
map({ 'i', 'x' }, '<C-s>', '<esc>:w<cr>')

-- jump to the end of the line in insert mode
map({ 'i', 'c' }, '<C-l>', '<C-o>A', { desc = 'Go to the end of the line' })

-- source buffer
map('n', '<leader>S', "<cmd>source % | lua print('buffer sourced')<cr>")

-- restart nvim, incl. write current buffer
map('n', '<leader>R', '<cmd>w | restart<cr>')

-- quit nvim
map('n', '<leader>QQ', function()
    vim.cmd('silent! wall')
    vim.cmd('wqa!')
end)

-- load the last session manually
map('n', '<leader>Qs', function()
    require('persistence').load({ last = true })
end)

-- select a session to load
map('n', '<leader>QS', function()
    require('persistence').select()
end)

-- load the last session for the current directory
map('n', '<leader>Ql', function()
    require('persistence').load()
end)

-- stop Persistence => session won't be saved on exit
map('n', '<leader>Qd', function()
    require('persistence').stop()
end)

-- copy and paste to system clipboard
map('v', '<leader>y', '"+y')
map('v', '<leader>p', '"+p')

-- copy and select all lines of current buffer
map('n', 'yg', ':%y<CR>', { noremap = true, silent = true })
map('n', 'vg', 'ggVG', { noremap = true, silent = true })

-- make Y behave like C and D - copy text until end of line
map('n', 'Y', 'yg_')

-- open new buffer
map('n', '<leader>n', '<cmd>enew<cr>')

-- delete buffer
map('n', '<leader>DB', '<cmd>bdelete<cr>')

-- open buffer via buffer list
map('n', '<C-b>', '<cmd>ls<cr>:b<space>')

-- join lines, cursor doesn't move
map('n', 'J', 'mzJ`z')

-- jump up and down a page and center cursor
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- center next and previous search results
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- switch between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- move lines up or down in normal, insert, and visual modes
map('n', '<A-j>', ':m .+1<cr>==')
map('n', '<A-k>', ':m .-2<cr>==')
map('i', '<A-j>', '<esc>:m .+1<cr>==gi')
map('i', '<A-k>', '<esc>:m .-2<cr>==gi')
map('v', '<A-j>', ":m '>+1<cr>gv=gv")
map('v', '<A-k>', ":m '<-2<cr>gv=gv")

-- helps you change all occurrences of the word the cursor is on
map('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
