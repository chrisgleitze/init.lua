vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("cg/big_files", { clear = true }),
    desc = "Disable features in big files",
    pattern = "bigfile",
    callback = function(args)
        vim.schedule(function()
            vim.bo[args.buf].syntax = vim.filetype.match({ buf = args.buf }) or ""
        end)
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("cg/last_location", { clear = true }),
    desc = "Go to the last location when opening a buffer",
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight effect for yanked text",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
    end,
})
