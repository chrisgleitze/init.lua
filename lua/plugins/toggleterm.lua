return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup({
            direction = 'float',
            open_mapping = [[<leader>T]],
            float_opts = {
                width = 70,
            },
        })
    end,
}
