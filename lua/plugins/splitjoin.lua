-- join and split code block
require('mini.splitjoin').setup({})

vim.keymap.set('n', '<leader>sj', function()
    require('mini.splitjoin').toggle()
end)
