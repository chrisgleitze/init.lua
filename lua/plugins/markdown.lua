return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = 'markdown',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        keys = {
            {
                '<leader>Md',
                function()
                    require('render-markdown').buf_toggle()
                end,
                ft = 'markdown',
            },
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            -- don't render large Markdown files
            max_file_size = 1.5,
            link = {
                enabled = false, -- inline link icon rendering
                footnote = {
                    enabled = true,
                    superscript = true,
                },
            },
        },
    },

    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && npm install && git restore .',
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
