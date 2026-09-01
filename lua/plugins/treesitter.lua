local function select_ts(query)
    return function()
        require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
    end
end

local function goto_ts(fn, query)
    return function()
        require('nvim-treesitter-textobjects.move')[fn](query, 'textobjects')
    end
end

local function swap_ts(fn, query)
    return function()
        require('nvim-treesitter-textobjects.swap')[fn](query)
    end
end

-- modes for textobject keymaps
local xo = { 'x', 'o' }
local nxo = { 'n', 'x', 'o' }

return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        cmd = { 'TSInstall', 'TSInstallFromGrammar', 'TSUpdate', 'TSUninstall', 'TSLog' },
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
                'typst',
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
    },
    {
        -- syntax aware textobjects: select, move, swap
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- the default branch is master, which targets the old nvim-treesitter API
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        keys = {
            -- select
            { 'af', select_ts('@function.outer'), mode = xo, desc = 'a function' },
            { 'if', select_ts('@function.inner'), mode = xo, desc = 'inner function' },
            { 'ac', select_ts('@class.outer'), mode = xo, desc = 'a class' },
            { 'ic', select_ts('@class.inner'), mode = xo, desc = 'inner class' },
            { 'aa', select_ts('@parameter.outer'), mode = xo, desc = 'an argument' },
            { 'ia', select_ts('@parameter.inner'), mode = xo, desc = 'inner argument' },
            { 'ai', select_ts('@conditional.outer'), mode = xo, desc = 'a conditional' },
            { 'ii', select_ts('@conditional.inner'), mode = xo, desc = 'inner conditional' },
            { 'al', select_ts('@loop.outer'), mode = xo, desc = 'a loop' },
            { 'il', select_ts('@loop.inner'), mode = xo, desc = 'inner loop' },
            { 'a/', select_ts('@comment.outer'), mode = xo, desc = 'a comment' },

            -- move
            { ']f', goto_ts('goto_next_start', '@function.outer'), mode = nxo, desc = 'next function' },
            { '[f', goto_ts('goto_previous_start', '@function.outer'), mode = nxo, desc = 'previous function' },
            { ']F', goto_ts('goto_next_end', '@function.outer'), mode = nxo, desc = 'next function end' },
            { '[F', goto_ts('goto_previous_end', '@function.outer'), mode = nxo, desc = 'previous function end' },
            { ']c', goto_ts('goto_next_start', '@class.outer'), mode = nxo, desc = 'next class' },
            { '[c', goto_ts('goto_previous_start', '@class.outer'), mode = nxo, desc = 'previous class' },
            { ']a', goto_ts('goto_next_start', '@parameter.inner'), mode = nxo, desc = 'next argument' },
            { '[a', goto_ts('goto_previous_start', '@parameter.inner'), mode = nxo, desc = 'previous argument' },

            -- swap
            { '<leader>sa', swap_ts('swap_next', '@parameter.inner'), desc = '[s]wap next [a]rgument' },
            { '<leader>sA', swap_ts('swap_previous', '@parameter.inner'), desc = '[s]wap previous [A]rgument' },
        },
        opts = {
            select = {
                -- jump forward to the textobject if the cursor is not inside one yet
                lookahead = true,
                selection_modes = {
                    ['@parameter.outer'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.outer'] = 'V',
                },
                include_surrounding_whitespace = false,
            },
            move = { set_jumps = true },
        },
        config = function(_, opts)
            require('nvim-treesitter-textobjects').setup(opts)
        end,
    },
}
