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
        { '<leader>go', '<cmd>Octo<cr>', desc = '[g]it [o]cto actions' },
        { '<leader>gpi', '<cmd>Octo issue list<cr>', desc = '[g]it [p]R/issues: list [i]ssues' },
        { '<leader>gpl', '<cmd>Octo pr list<cr>', desc = '[g]it [p]R: [l]ist' },
        { '<leader>gpe', '<cmd>Octo pr edit<cr>', desc = '[g]it [p]R: [e]dit current/selected' },
        { '<leader>gpr', '<cmd>Octo review<cr>', desc = '[g]it [p]R: start [r]eview' },
        { '<leader>gpc', '<cmd>Octo review comments<cr>', desc = '[g]it [p]R: review [c]omments' },
        { '<leader>gps', '<cmd>Octo review submit<cr>', desc = '[g]it [p]R: [s]ubmit review' },
        { '<leader>gpb', '<cmd>Octo pr browser<cr>', desc = '[g]it [p]R: open in [b]rowser' },
    },
}
