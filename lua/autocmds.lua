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

-- config for built-in undotree plugin
vim.api.nvim_create_autocmd("FileType", {
    pattern = "nvim-undotree",
    callback = function()
        vim.cmd.wincmd("H")
        vim.api.nvim_win_set_width(0, 40)
    end,
})
