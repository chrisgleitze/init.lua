local notebook = vim.fn.expand('~/projects/zk')

local function zk(command, options)
    return function()
        require('zk.commands').get(command)(vim.tbl_extend('force', { notebook_path = notebook }, options or {}))
    end
end

return {
    'zk-org/zk-nvim',
    name = 'zk',
    ft = 'markdown',
    cmd = { 'ZkNew', 'ZkNotes', 'ZkBacklinks', 'ZkLinks', 'ZkInsertLink', 'ZkTags' },
    init = function()
        vim.env.ZK_NOTEBOOK_DIR = notebook
    end,
    opts = {
        picker = 'fzf_lua',
        lsp = {
            config = {
                name = 'zk',
                cmd = { 'zk', 'lsp' },
                filetypes = { 'markdown' },
            },
            auto_attach = { enabled = true },
        },
    },
    keys = {
        {
            '<leader>zn',
            function()
                require('zk.commands').get('ZkNew')({ notebook_path = notebook, title = vim.fn.input('Title: ') })
            end,
        },
        { '<leader>zf', zk('ZkNotes') },
        { '<leader>zb', zk('ZkBacklinks') },
        { '<leader>zl', zk('ZkLinks') },
        { '<leader>zi', zk('ZkInsertLink') },
        { '<leader>zt', zk('ZkTags') },
    },
}
