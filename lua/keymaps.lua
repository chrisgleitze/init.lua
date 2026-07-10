local map = vim.keymap.set

local clear = function()
    vim.cmd.nohlsearch()
    vim.cmd.echo()
    vim.diagnostic.config({ virtual_lines = false })
    pcall(vim.lsp.buf.clear_references)
    pcall(function()
        local ls = require('luasnip')
        if ls.in_snippet() then
            ls.unlink_current()
        end
    end)
end

-- Esc clears UI, stops snippet session
map('n', '<Esc>', clear)
map({ 'i', 's', 'x', 'o', 'c' }, '<Esc>', function()
    clear()
    return '<Esc>'
end, { expr = true })

-- open native undotree
map('n', '<leader>U', function()
    vim.cmd.packadd('nvim.undotree')
    vim.cmd.Undotree()
end)

-- open Lazy.nvim plugin manager
map('n', '<leader>L', '<cmd>Lazy<cr>')

-- open Mason
map('n', '<leader>Ma', '<cmd>Mason<cr>')

-- write buffer in normal
map('n', '<C-s>', function()
    vim.cmd('write ++p')
    print('buffer saved')
end)
-- and in insert mode
map({ 'i', 'x' }, '<C-s>', '<esc>:write ++p<cr>')

-- jump to the end of the line in insert, command mode
map({ 'i', 'c' }, '<C-l>', '<C-o>A')

-- toggle blink completion for current buffer
map('n', '<leader>c', function()
    if vim.b.completion == false then
        vim.b.completion = nil
    else
        vim.b.completion = false
        pcall(function()
            require('blink.cmp').hide()
        end)
    end

    local status = vim.b.completion == false and 'disabled' or 'enabled'
    vim.notify('Blink completion ' .. status .. ' for this buffer')
end)

-- restart nvim, incl. write current buffer
map('n', '<leader>R', '<cmd>write ++p | restart<cr>')

-- quit nvim
map('n', '<leader>QQ', function()
    vim.cmd('silent! wall')
    vim.cmd('wqa!')
end)

-- make Y behave like C and D - copy text until end of line
map('n', 'Y', 'yg_')

-- open new buffer
map('n', '<leader>n', '<cmd>enew<cr>')

-- delete buffer
map('n', '<leader>DB', '<cmd>bdelete<cr>')

-- open buffer via buffer list
map('n', '<C-b>', '<cmd>ls<cr>:b<space>')

-- opens lazygit instance of current directory in new tmux windows
map('n', '<leader>gg', function()
    if not vim.env.TMUX then
        vim.notify('Not inside tmux', vim.log.levels.WARN)
        return
    end

    vim.fn.jobstart({ 'tmux', 'new-window', '-c', vim.fn.getcwd(), '--', 'lazygit' }, { detach = true })
end)

-- join lines, cursor doesn't move
map('n', 'J', 'mzJ`z')

-- jump up and down a page and center cursor
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- center next and previous search results
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- nvim-tmux-navigation
local function tmux_navigate(wincmd, pane)
    return function()
        local win = vim.api.nvim_get_current_win()
        vim.cmd.wincmd(wincmd)
        if win == vim.api.nvim_get_current_win() and vim.env.TMUX then
            local zoomed = vim.fn.system({ 'tmux', 'display-message', '-p', '#{window_zoomed_flag}' }) == '1\n'
            if zoomed then
                return
            end

            vim.fn.jobstart({ 'tmux', 'select-pane', '-' .. pane }, { detach = true })
        end
    end
end

map('n', '<C-h>', tmux_navigate('h', 'L'))
map('n', '<C-j>', tmux_navigate('j', 'D'))
map('n', '<C-k>', tmux_navigate('k', 'U'))
map('n', '<C-l>', tmux_navigate('l', 'R'))

-- move lines up or down in normal, insert, and visual modes
map('n', '<A-j>', ':m .+1<cr>==')
map('n', '<A-k>', ':m .-2<cr>==')
map('i', '<A-j>', '<esc>:m .+1<cr>==gi')
map('i', '<A-k>', '<esc>:m .-2<cr>==gi')
map('v', '<A-j>', ":m '>+1<cr>gv=gv")
map('v', '<A-k>', ":m '<-2<cr>gv=gv")

-- helps you change all occurrences of the word the cursor is on
map('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
