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
    callback = function(args)
        if not vim.bo[args.buf].modifiable or vim.bo[args.buf].buftype ~= '' then
            return
        end

        local view = vim.fn.winsaveview()
        vim.cmd([[keepjumps keeppatterns silent! %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

-- don't auto continue comments in new line
autocmd('FileType', {
    group = vim.api.nvim_create_augroup('no_auto_comment', {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

-- replaces defined patterns in specific files with ***
autocmd({ 'BufReadPost', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('cg/cloak', { clear = true }),
    pattern = { '.env*', '.dev.vars', 'auth.json', 'wrangler.toml' },
    callback = function()
        -- Conceal each non-space value char after ":" or "=" with "*".
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nvic'
        vim.api.nvim_set_hl(0, 'CgCloak', { link = 'Comment', default = true })
        vim.cmd([[syntax match CgCloak /\%([:=]\s*.*\)\@<=\S/ conceal cchar=*]])
        -- env.vim wraps values in envValue, so add a contained match for .env files.
        vim.cmd([[syntax match CgCloakEnv /\S/ contained conceal cchar=* containedin=envValue]])
    end,
})

-- highlight on yank effect
autocmd({ 'TextYankPost', 'TextPutPost' }, {
    group = vim.api.nvim_create_augroup('yank_group', { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, 'YankHighlight', {
            bg = '#f5c542',
        })

        vim.hl.hl_op({
            higroup = 'YankHighlight',
            timeout = 40,
        })
    end,
})
