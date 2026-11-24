local function configure()
    require('neo-tree').setup({
        filesystem = {
            follow_current_file = { enabled = true },
        },
        window = {
            width = 35,
        },
    })
end

require('plugin_loader').on_command('neo-tree', 'Neotree', configure)

local function toggle(position)
    require('plugin_loader').load('neo-tree', configure)
    require('neo-tree.command').execute({ position = position, toggle = true }, { force_open_folders = {} })
end

vim.keymap.set('n', '<leader>t', function()
    toggle('left')
end)
vim.keymap.set('n', '<leader>T', function()
    toggle('current')
end)
