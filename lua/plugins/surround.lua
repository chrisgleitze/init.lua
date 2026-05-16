return {
    'echasnovski/mini.surround',
    recommended = true,
    version = false,
    keys = {
        { 'ys', mode = { 'n', 'x' }, desc = 'Add surrounding' },
        { 'ds', mode = 'n', desc = 'Delete surrounding' },
        { 'cs', mode = 'n', desc = 'Replace surrounding' },
        { 'S', mode = 'x', desc = 'Add surrounding to selection' },
        { 'yss', mode = 'n', desc = 'Add surrounding to line' },
    },
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
