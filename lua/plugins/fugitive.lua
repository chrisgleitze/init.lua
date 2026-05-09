return {
    'tpope/vim-fugitive',
    cmd = {
        'Git',
        'Gwrite',
    },
    dependencies = {
        {
            'junegunn/gv.vim',
            cmd = 'GV',
        },
    },
    keys = {
        { '<leader>Gi', '<cmd>Git<cr>' },
        { '<leader>Gb', '<cmd>Git blame<cr>' },
        { '<leader>Gl', '<cmd>Git log<cr>' },
        { '<leader>Gd', '<cmd>Git diff<cr>' },
        { '<leader>Gw', '<cmd>Gwrite | Git commit<cr>' },
        { '<leader>Gp', '<cmd>Git push<cr>' },

        { '<leader>GVV', '<cmd>GV<cr>' },
        { '<leader>GV!', '<cmd>GV!<cr>' },
        { '<leader>GV?', '<cmd>GV?<cr>' },
    },
}
