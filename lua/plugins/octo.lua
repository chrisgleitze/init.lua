-- edit and review GitHub issues and pull requests
require('octo').setup({
    picker = 'fzf-lua',
    enable_builtin = true,
    default_remote = { 'upstream', 'origin' },
    use_local_fs = true,
})

vim.keymap.set('n', '<leader>go', '<cmd>Octo<cr>')
vim.keymap.set('n', '<leader>gpi', '<cmd>Octo issue list<cr>')
vim.keymap.set('n', '<leader>gpl', '<cmd>Octo pr list<cr>')
vim.keymap.set('n', '<leader>gpe', '<cmd>Octo pr edit<cr>')
vim.keymap.set('n', '<leader>gpr', '<cmd>Octo review<cr>')
vim.keymap.set('n', '<leader>gpc', '<cmd>Octo review comments<cr>')
vim.keymap.set('n', '<leader>gps', '<cmd>Octo review submit<cr>')
vim.keymap.set('n', '<leader>gpb', '<cmd>Octo pr browser<cr>')
vim.keymap.set('n', '<leader>gpd', '<cmd>Octo pr diff<cr>')
vim.keymap.set('n', '<leader>gpk', '<cmd>Octo pr checks<cr>')
vim.keymap.set('n', '<leader>gpu', '<cmd>Octo pr runs<cr>')
vim.keymap.set('n', '<leader>gpx', '<cmd>Octo pr checkout<cr>')
