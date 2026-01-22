return {
    'echasnovski/mini.surround',
    recommended = true,
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        mappings = {
            add = 'ys', -- Add surrounding in Normal and Visual modes (see below)
            delete = 'ds', -- Delete surrounding
            find = '', -- Find surrounding
            find_left = '', -- Find surrounding to the left
            highlight = '', -- Highlight surrounding
            replace = 'cs', -- Replace surrounding
            update_n_lines = '', -- Update `n_lines`
            suffix_last = '',
            suffix_next = '',
        },
        search_method = 'cover_or_next',
    },
    config = function(_, opts)
        require('mini.surround').setup(opts)

        -- add surrounding to visual selection
        vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<cr>]], { silent = true })

        -- Make special mapping for "add surrounding for line"
        vim.keymap.set('n', 'yss', 'ys_', { remap = true })
    end,
}
