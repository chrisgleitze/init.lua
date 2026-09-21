require('neo-tree').setup({
    filesystem = {
        follow_current_file = { enabled = true },
    },
    window = {
        width = 35,
    },
})

vim.keymap.set('n', '<leader>t', '<cmd>Neotree toggle<cr>')
vim.keymap.set('n', '<leader>T', '<cmd>Neotree position=current toggle<cr>')
