return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()
    end,
    keys = function()
        local function harpoon_list(action)
            return function()
                local list = require('harpoon'):list()
                list[action](list)
            end
        end

        local keys = {
            { '<leader>A', harpoon_list('prepend') },
            { '<leader>a', harpoon_list('add') },
            {
                '<C-e>',
                function()
                    local harpoon = require('harpoon')
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
            },
        }

        local function select(index)
            return function()
                require('harpoon'):list():select(index)
            end
        end

        vim.list_extend(keys, {
            -- switch to harpooned file 1-8
            { '<leader>q', select(1) },
            { '<leader>w', select(2) },
            { '<leader>e', select(3) },
            { '<leader>r', select(4) },
            { '<leader>u', select(5) },
            { '<leader>i', select(6) },
            { '<leader>o', select(7) },
            { '<leader>p', select(8) },
        })

        local function replace(index)
            return function()
                require('harpoon'):list():replace_at(index)
            end
        end

        vim.list_extend(keys, {
            -- substitute harpooned file 1-8 with new files
            { '<leader><C-q>', replace(1) },
            { '<leader><C-w>', replace(2) },
            { '<leader><C-e>', replace(3) },
            { '<leader><C-r>', replace(4) },
            { '<leader><C-u>', replace(5) },
            { '<leader><C-i>', replace(6) },
            { '<leader><C-o>', replace(7) },
            { '<leader><C-p>', replace(8) },
        })

        return keys
    end,
}
