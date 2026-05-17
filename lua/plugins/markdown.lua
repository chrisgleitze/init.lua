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
            -- Reuse the editor-wide bigfile guard so long notes or generated
            -- Markdown stay cheap to open and scroll.
            ignore = function(bufnr)
                return require('bigfile').is_big(bufnr)
            end,
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
