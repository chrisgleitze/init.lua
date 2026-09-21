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

vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
    once = true,
    callback = function()
        if #vim.api.nvim_list_uis() == 0 then
            return
        end

        require('nvim-treesitter').install(parsers)
    end,
})

require('nvim-treesitter-textobjects').setup({
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
})

-- modes for textobject keymaps
local xo = { 'x', 'o' }
local nxo = { 'n', 'x', 'o' }

-- select
vim.keymap.set(xo, 'af', select_ts('@function.outer'), { desc = 'a function' })
vim.keymap.set(xo, 'if', select_ts('@function.inner'), { desc = 'inner function' })
vim.keymap.set(xo, 'ac', select_ts('@class.outer'), { desc = 'a class' })
vim.keymap.set(xo, 'ic', select_ts('@class.inner'), { desc = 'inner class' })
vim.keymap.set(xo, 'aa', select_ts('@parameter.outer'), { desc = 'an argument' })
vim.keymap.set(xo, 'ia', select_ts('@parameter.inner'), { desc = 'inner argument' })
vim.keymap.set(xo, 'ai', select_ts('@conditional.outer'), { desc = 'a conditional' })
vim.keymap.set(xo, 'ii', select_ts('@conditional.inner'), { desc = 'inner conditional' })
vim.keymap.set(xo, 'al', select_ts('@loop.outer'), { desc = 'a loop' })
vim.keymap.set(xo, 'il', select_ts('@loop.inner'), { desc = 'inner loop' })
vim.keymap.set(xo, 'a/', select_ts('@comment.outer'), { desc = 'a comment' })

-- move
vim.keymap.set(nxo, ']f', goto_ts('goto_next_start', '@function.outer'), { desc = 'next function' })
vim.keymap.set(nxo, '[f', goto_ts('goto_previous_start', '@function.outer'), { desc = 'previous function' })
vim.keymap.set(nxo, ']F', goto_ts('goto_next_end', '@function.outer'), { desc = 'next function end' })
vim.keymap.set(nxo, '[F', goto_ts('goto_previous_end', '@function.outer'), { desc = 'previous function end' })
vim.keymap.set(nxo, ']c', goto_ts('goto_next_start', '@class.outer'), { desc = 'next class' })
vim.keymap.set(nxo, '[c', goto_ts('goto_previous_start', '@class.outer'), { desc = 'previous class' })
vim.keymap.set(nxo, ']a', goto_ts('goto_next_start', '@parameter.inner'), { desc = 'next argument' })
vim.keymap.set(nxo, '[a', goto_ts('goto_previous_start', '@parameter.inner'), { desc = 'previous argument' })

-- swap
vim.keymap.set('n', '<leader>sa', swap_ts('swap_next', '@parameter.inner'), { desc = '[s]wap next [a]rgument' })
vim.keymap.set('n', '<leader>sA', swap_ts('swap_previous', '@parameter.inner'), { desc = '[s]wap previous [A]rgument' })
