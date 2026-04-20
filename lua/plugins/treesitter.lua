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
        vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
            group = group,
            callback = function()
                if vim.bo.buftype ~= '' then
                    return
                end

                pcall(vim.treesitter.start, 0)
            end,
        })

        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'VeryLazy',
            once = true,
            callback = function()
                require('nvim-treesitter').install(parsers)
            end,
        })
    end,
}
