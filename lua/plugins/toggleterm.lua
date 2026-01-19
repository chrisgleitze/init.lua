return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup({
            direction = 'float',
            open_mapping = [[<c-t>]],
            float_opts = {
                width = 70,
            },
        })
    end,
}
