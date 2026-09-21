local harpoon = require('harpoon')
harpoon:setup()

local function harpoon_list(action)
    return function()
        local list = require('harpoon'):list()
        list[action](list)
    end
end

vim.keymap.set('n', '<leader>A', harpoon_list('prepend'))
vim.keymap.set('n', '<leader>a', harpoon_list('add'))
vim.keymap.set('n', '<C-e>', function()
    local current_harpoon = require('harpoon')
    current_harpoon.ui:toggle_quick_menu(current_harpoon:list())
end)

local function select(index)
    return function()
        require('harpoon'):list():select(index)
    end
end

-- switch to harpooned file 1-8
vim.keymap.set('n', '<leader>q', select(1))
vim.keymap.set('n', '<leader>w', select(2))
vim.keymap.set('n', '<leader>e', select(3))
vim.keymap.set('n', '<leader>r', select(4))
vim.keymap.set('n', '<leader>u', select(5))
vim.keymap.set('n', '<leader>i', select(6))
vim.keymap.set('n', '<leader>o', select(7))
vim.keymap.set('n', '<leader>p', select(8))

local function replace(index)
    return function()
        require('harpoon'):list():replace_at(index)
    end
end

-- substitute harpooned file 1-8 with new files
vim.keymap.set('n', '<leader><C-q>', replace(1))
vim.keymap.set('n', '<leader><C-w>', replace(2))
vim.keymap.set('n', '<leader><C-e>', replace(3))
vim.keymap.set('n', '<leader><C-r>', replace(4))
vim.keymap.set('n', '<leader><C-u>', replace(5))
vim.keymap.set('n', '<leader><C-i>', replace(6))
vim.keymap.set('n', '<leader><C-o>', replace(7))
vim.keymap.set('n', '<leader><C-p>', replace(8))
