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

            -- WSL: /etc/wsl.conf sets appendWindowsPath=false, so the bundled
            -- opener dies with "spawn cmd.exe ENOENT". There is no Linux browser
            -- here either, so hand the URL to the Windows default browser through
            -- the absolute interop path instead. cwd must be a path cmd.exe can
            -- resolve or it warns about UNC paths.
            if vim.fn.executable('/mnt/c/Windows/System32/cmd.exe') == 1 then
                vim.cmd([[
                    function! MkdpBrowser(url) abort
                      call jobstart(['/mnt/c/Windows/System32/cmd.exe', '/c', 'start', '""', a:url],
                            \ {'cwd': '/mnt/c', 'detach': v:true})
                    endfunction
                ]])
                vim.g.mkdp_browserfunc = 'MkdpBrowser'
            end
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
