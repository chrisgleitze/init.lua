return {
    'tpope/vim-fugitive',
    dependencies = { 'junegunn/gv.vim' },
    config = function()
        local map = vim.keymap.set
        map('n', '<leader>Gi', '<cmd>Git <cr>')
        map('n', '<leader>Gb', '<cmd>Git blame<cr>')
        map('n', '<leader>Gl', '<cmd>Git log<cr>')
        map('n', '<leader>Gd', '<cmd>Git diff<cr>')
        map('n', '<leader>Gw', '<cmd>Gwrite | :G commit<cr>')
        map('n', '<leader>Gp', '<cmd>Git push<cr>')

        map('n', '<leader>GVV', '<cmd>GV<cr>')
        map('n', '<leader>GV!', '<cmd>GV!<cr>')
        map('n', '<leader>GV?', '<cmd>GV?<cr>')
    end,
}
