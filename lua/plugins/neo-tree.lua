return {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
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
        vim.keymap.set('n', '<leader>t', '<Cmd>Neotree toggle<CR>'),
        vim.keymap.set('n', '<leader>T', '<Cmd>Neotree position=current toggle<CR>'),
    },
}
