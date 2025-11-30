local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
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

-- remove whitespace when buffer is written
autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("cg/whitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- highlight effect for yanked text
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- config for built-in undotree plugin
vim.cmd.packadd("nvim.undotree") -- load plugin on startup
autocmd("FileType", {
    pattern = "nvim-undotree",
    callback = function()
        vim.cmd.wincmd("H")
        vim.api.nvim_win_set_width(0, 40)
    end,
})

-- quit Lazy.nvim with Esc
local user_grp = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function()
        vim.keymap.set("n", "<esc>", function()
            vim.api.nvim_win_close(0, false)
        end, { buffer = true, nowait = true })
    end,
    group = user_grp,
})
