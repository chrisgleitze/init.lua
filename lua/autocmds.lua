local autocmd = vim.api.nvim_create_autocmd

-- restore the last session when nvim starts without file args
-- autocmd('VimEnter', {
--     group = vim.api.nvim_create_augroup('cg/session_restore', { clear = true }),
--     nested = true,
--     callback = function()
--         if vim.fn.argc() > 0 then
--             return
--         end
--
--         if vim.bo.buftype ~= '' then
--             return
--         end
--
--         if vim.api.nvim_buf_get_name(0) ~= '' then
--             return
--         end
--
--         local ft = vim.bo.filetype
--         if ft == 'gitcommit' or ft == 'neo-tree' or ft == 'oil' then
--             return
--         end
--
--         require('persistence').load({ last = true })
--     end,
-- })

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

-- highlight on yank effect
autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('yank_group', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
