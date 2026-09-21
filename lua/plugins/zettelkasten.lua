local notebook = vim.fn.expand('~/projects/zk')

local function zk(command, options)
    return function()
        require('zk.commands').get(command)(vim.tbl_extend('force', { notebook_path = notebook }, options or {}))
    end
end

vim.env.ZK_NOTEBOOK_DIR = notebook

require('zk').setup({
    picker = 'fzf_lua',
    lsp = {
        config = {
            name = 'zk',
            cmd = { 'zk', 'lsp' },
            filetypes = { 'markdown' },
        },
        auto_attach = { enabled = true },
    },
})

vim.keymap.set('n', '<leader>zn', function()
    require('zk.commands').get('ZkNew')({ notebook_path = notebook, title = vim.fn.input('Title: ') })
end)
vim.keymap.set('n', '<leader>zf', zk('ZkNotes'))
vim.keymap.set('n', '<leader>zb', zk('ZkBacklinks'))
vim.keymap.set('n', '<leader>zl', zk('ZkLinks'))
vim.keymap.set('n', '<leader>zi', zk('ZkInsertLink'))
vim.keymap.set('n', '<leader>zt', zk('ZkTags'))
