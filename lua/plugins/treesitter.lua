return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    init = function()
        local parsers = {
            'bash',
            'c',
            'cpp',
            'gitcommit',
            'gitignore',
            'go',
            'graphql',
            'html',
            'java',
            'javascript',
            'json',
            'json5',
            'lua',
            'markdown',
            'markdown_inline',
            'php',
            'python',
            'query',
            'r',
            'regex',
            'rust',
            'scss',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        }

        local group = vim.api.nvim_create_augroup('cg/treesitter', { clear = true })
        -- Start parsers once the filetype is known. BufEnter would repeat this
        -- check on every window/buffer hop without adding useful work.
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            callback = function(args)
                if vim.bo[args.buf].buftype ~= '' then
                    return
                end

                -- Large files are still editable, but parser startup can make
                -- opening and scrolling them noticeably slower.
                if require('bigfile').is_big(args.buf) then
                    return
                end

                pcall(vim.treesitter.start, args.buf)
            end,
        })

        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'VeryLazy',
            once = true,
            callback = function()
                if #vim.api.nvim_list_uis() == 0 then
                    return
                end

                require('nvim-treesitter').install(parsers)
            end,
        })
    end,
}
