return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        -- {"3rd/image.nvim", opts = {}}, -- optional image support
    },
    opts = {
        filesystem = {
            follow_current_file = { enabled = true },
        },
        window = {
            width = 35,
        },
    },
    keys = {
        { '<leader>t', '<cmd>Neotree toggle<cr>' },
        { '<leader>T', '<cmd>Neotree position=current toggle<cr>' },
    },
}
