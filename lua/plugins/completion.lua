local blink = require('blink.cmp')

-- set capabilities before any lsp client can start
vim.lsp.config('*', { capabilities = blink.get_lsp_capabilities(nil, true) })

blink.setup({
    snippets = { preset = 'luasnip' },
    completion = {
        ghost_text = { enabled = true },
        menu = {
            border = 'none',
            scrollbar = true,
            draw = {
                treesitter = {},
                gap = 2,
                columns = {
                    { 'kind_icon', 'kind', gap = 1 },
                    { 'label', 'label_description', gap = 1 },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = false,
        },
    },
    sources = {
        per_filetype = {
            text = {}, -- disabled
            markdown = { 'lsp', 'path', 'snippets' },
        },
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    keymap = {
        ['<CR>'] = { 'select_and_accept', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
})

vim.api.nvim_create_autocmd('InsertEnter', {
    group = vim.api.nvim_create_augroup('cg/deferred_luasnip_setup', { clear = true }),
    once = true,
    callback = function()
        -- initialize snippet support when entering insert mode
        local luasnip = require('luasnip')
        luasnip.setup({
            history = true,
            delete_check_events = 'TextChanged',
            region_check_events = 'CursorMoved',
        })

        -- load friendly-snippets on demand
        require('luasnip.loaders.from_vscode').lazy_load()

        -- load custom snippets on demand
        require('luasnip.loaders.from_vscode').lazy_load({
            paths = { vim.fn.stdpath('config') .. '/snippets' },
        })
    end,
})
