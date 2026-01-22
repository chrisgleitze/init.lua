return {
    'tpope/vim-fugitive',
    dependencies = { 'junegunn/gv.vim' },
    config = function()
        local map = vim.keymap.set
        map('n', '<leader>Gi', '<cmd>Git <CR>')
        map('n', '<leader>Gb', '<cmd>Git blame<CR>')
        map('n', '<leader>Gl', '<cmd>Git log<CR>')
        map('n', '<leader>Gd', '<cmd>Git diff<CR>')
        map('n', '<leader>Gw', '<cmd>Gwrite | :G commit<CR>')
        map('n', '<leader>Gp', '<cmd>Git push<CR>')

        map('n', '<leader>GVV', '<cmd>GV<CR>')
        map('n', '<leader>GV!', '<cmd>GV!<CR>')
        map('n', '<leader>GV?', '<cmd>GV?<CR>')
    end,
}
