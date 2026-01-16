return {
    'tpope/vim-fugitive',
    config = function()
        local map = vim.keymap.set
        map('n', '<leader>Gi', '<cmd>Git <CR>')
        map('n', '<leader>Gb', '<cmd>Git blame<CR>')
        map('n', '<leader>Gl', '<cmd>Git log<CR>')
        map('n', '<leader>Gd', '<cmd>Git diff<CR>')
        map('n', '<leader>Gw', '<cmd>Gwrite | :G commit<CR>')
        map('n', '<leader>Gp', '<cmd>Git push<CR>')
    end,
}
