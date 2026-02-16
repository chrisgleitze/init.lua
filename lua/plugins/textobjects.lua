return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    branch = 'main',
    event = 'BufReadPre',
    config = function()
        local tos = require('nvim-treesitter-textobjects.select').select_textobject

        ---@param lhs string
        ---@param textobject string
        local function map(lhs, textobject)
            vim.keymap.set({ 'x', 'o' }, lhs, function()
                tos(textobject, 'textobjects')
            end)
        end

        -- function
        map('af', '@function.outer')
        map('if', '@function.inner')

        -- classes
        map('ac', '@class.outer')
        map('ic', '@class.inner')

        -- parameters/arguments
        map('aa', '@parameter.outer')
        map('ia', '@parameter.inner')

        -- conditionals (if, switch, etc.)
        map('ai', '@conditional.outer')
        map('ii', '@conditional.inner')

        -- loops (for, while, etc.)
        map('al', '@loop.outer')
        map('il', '@loop.inner')

        -- blocks
        map('ab', '@block.outer')
        map('ib', '@block.inner')

        -- comments
        map('ag', '@comment.outer')

        -- Calls (Funktionsaufrufe)
        map('am', '@call.outer')
        map('im', '@call.inner')

        -- move: jump to next/previous textobject
        local move = require('nvim-treesitter-textobjects.move')

        ---@param lhs string
        ---@param query string
        ---@param direction 'next'|'previous'
        local function goto_map(lhs, query, direction)
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
                move['goto_' .. direction .. '_start'](query, 'textobjects')
            end)
        end

        goto_map(']f', '@function.outer', 'next')
        goto_map('[f', '@function.outer', 'previous')
        goto_map(']c', '@class.outer', 'next')
        goto_map('[c', '@class.outer', 'previous')
        goto_map(']a', '@parameter.outer', 'next')
        goto_map('[a', '@parameter.outer', 'previous')

        -- swap: swap parameters
        local swap = require('nvim-treesitter-textobjects.swap')

        vim.keymap.set('n', '<leader>sn', function()
            swap.swap_next('@parameter.inner')
        end)
        vim.keymap.set('n', '<leader>sp', function()
            swap.swap_previous('@parameter.inner')
        end)
    end,
}
