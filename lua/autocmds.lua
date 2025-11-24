local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("cg/whitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("TextYankPost", {
    desc = "Highlight effect for yanked text",
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
