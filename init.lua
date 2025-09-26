-- leader key
vim.g.mapleader = " "

-- disable built-in stuff I don't use
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugi = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zipPlugin = 1

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- configure plugins
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    ui = {
        border = "rounded",
    },
    -- enable or disable luarocks
    rocks = {
        enabled = true,
    },
    change_detection = { notify = false },
})

-- load general settings and more
require("settings")
require("autocmds")
require("keymaps")
require("lsp")
