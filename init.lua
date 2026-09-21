-- enable new quicker Lua module loader
vim.loader.enable()

local g = vim.g

-- leader key
g.mapleader = ' '

-- disable built-in stuff I don't use
g.loaded_2html_plugin = 1
g.did_install_default_menus = 1
g.loaded_gzip = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_logiPat = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_nvim_dir_plugin = 1
g.loaded_nvim_zip_plugin = 1
g.loaded_remote_plugins = 1
g.loaded_rrhelper = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

-- install and configure plugins
require('plugins')

-- load general settings and more
require('settings')
require('keymaps')
require('cmdatom')
require('autocmds')
require('cwd')
require('sessions')
require('lsp')
