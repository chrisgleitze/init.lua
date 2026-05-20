return {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        picker = 'fzf-lua',
        enable_builtin = true,
        default_remote = { 'upstream', 'origin' },
        use_local_fs = true,
    },
    keys = {
        { '<leader>go', '<cmd>Octo<cr>' },
        { '<leader>gpi', '<cmd>Octo issue list<cr>' },
        { '<leader>gpl', '<cmd>Octo pr list<cr>' },
        { '<leader>gpe', '<cmd>Octo pr edit<cr>' },
        { '<leader>gpr', '<cmd>Octo review<cr>' },
        { '<leader>gpc', '<cmd>Octo review comments<cr>' },
        { '<leader>gps', '<cmd>Octo review submit<cr>' },
        { '<leader>gpb', '<cmd>Octo pr browser<cr>' },
        { '<leader>gpd', '<cmd>Octo pr diff<cr>' },
        { '<leader>gpk', '<cmd>Octo pr checks<cr>' },
        { '<leader>gpu', '<cmd>Octo pr runs<cr>' },
        { '<leader>gpx', '<cmd>Octo pr checkout<cr>' },
    },
}
