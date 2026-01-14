return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup()

        local set = vim.keymap.set

        set('n', '<leader>A', function()
            harpoon:list():prepend()
        end)
        set('n', '<leader>a', function()
            harpoon:list():add()
        end)
        set('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- switch to harpooned file 1-4
        set('n', '<leader>q', function()
            harpoon:list():select(1)
        end)
        set('n', '<leader>w', function()
            harpoon:list():select(2)
        end)
        set('n', '<leader>e', function()
            harpoon:list():select(3)
        end)
        set('n', '<leader>r', function()
            harpoon:list():select(4)
        end)

        -- susbstitute harpoon file 1-4 with new files
        set('n', '<leader><C-q>', function()
            harpoon:list():replace_at(1)
        end)
        set('n', '<leader><C-w>', function()
            harpoon:list():replace_at(2)
        end)
        set('n', '<leader><C-e>', function()
            harpoon:list():replace_at(3)
        end)
        set('n', '<leader><C-r>', function()
            harpoon:list():replace_at(4)
        end)

        -- toggle previous & next buffers stored within Harpoon list
        -- set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
