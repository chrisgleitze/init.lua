require('mini.surround').setup({
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
    -- `s` as "nearest common surrounding"
    -- `dss` deletes it and `css` changes it
    custom_surroundings = {
        s = {
            input = { { '%b()', '%b[]', '%b{}', '".-"', "'.-'", '`.-`' }, '^.().*().$' },
        },
    },
})

-- add surrounding to visual selection
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<cr>]], {
    silent = true,
    desc = 'Add surrounding to selection',
})

-- Make special mapping for "add surrounding for line"
vim.keymap.set('n', 'yss', 'ys_', { remap = true, desc = 'Add surrounding to line' })
