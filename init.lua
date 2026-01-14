local g = vim.g

-- leader key
g.mapleader = ' '

-- disable built-in stuff I don't use
g.loaded_2html_plugin = 1
g.loaded_gzip = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_logiPat = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrw = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_rplugin = 1
g.loaded_rrhelper = 1
g.loaded_spec = 1
g.loaded_spellfile_plugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tohtml = 1
g.loaded_tutor = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- configure plugins
require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    ui = {
        border = 'rounded',
    },
    -- enable or disable luarocks
    rocks = {
        enabled = false,
    },
    change_detection = { notify = false },
})

-- load general settings and more
require('settings')
require('keymaps')
require('autocmds')
require('lsp')
