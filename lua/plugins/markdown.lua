return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = 'markdown',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            link = {
                enabled = false, -- inline link icon rendering
                footnote = {
                    enabled = true,
                    superscript = true,
                },
            },
            keymaps = {
                vim.keymap.set('n', '<leader>Md', function()
                    require('render-markdown').buf_toggle()
                end),
            },
        },
    },

    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
        keys = {
            {
                '<leader>Mp',
                ft = 'markdown',
                '<cmd>MarkdownPreviewToggle<cr>',
            },
        },
    },
}
