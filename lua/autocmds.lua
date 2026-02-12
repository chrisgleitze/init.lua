local autocmd = vim.api.nvim_create_autocmd

-- go to the last location when opening a buffer
autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('cg/last_location', { clear = true }),
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

-- remove whitespace when buffer is written
autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('cg/whitespace', {}),
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- highlight effect for yanked text
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- quit Lazy.nvim with Esc
autocmd('FileType', {
    pattern = 'lazy',
    callback = function()
        vim.keymap.set('n', '<esc>', function()
            vim.api.nvim_win_close(0, false)
        end, { buffer = true, nowait = true })
    end,
})

-- don't auto continue comments in new line
autocmd('FileType', {
    group = vim.api.nvim_create_augroup('no_auto_comment', {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})
