-- completion
return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            {
                -- snippet engine
                'L3MON4D3/LuaSnip',
                dependencies = { 'rafamadriz/friendly-snippets' },
                version = 'v2.*',
                build = 'make install_jsregexp',
                config = function()
                    local luasnip = require('luasnip')
                    luasnip.setup({
                        history = true,
                        delete_check_events = 'TextChanged',
                        region_check_events = 'CursorMoved',
                    })
                    -- loads friendly-snippets
                    require('luasnip.loaders.from_vscode').lazy_load()
                    -- my custom snippets
                    require('luasnip.loaders.from_vscode').lazy_load({
                        paths = { vim.fn.stdpath('config') .. '/snippets' },
                    })
                end,
            },
            {
                'saghen/blink.compat',
                version = not vim.g.lazyvim_blink_main and '*',
            },
        },
        opts = {
            snippets = { preset = 'luasnip' },
            completion = {
                ghost_text = { enabled = true },
                menu = {
                    -- Delay the completion menu a bit as well, so suggestions
                    -- do not pop up immediately while typing quickly.
                    auto_show_delay_ms = 250,
                    border = 'none',
                    scrollbar = true,
                    draw = {
                        -- Avoid extra parser work while rendering completion items.
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
                    -- Delay docs slightly so quick typing does not constantly
                    -- open and redraw the documentation window.
                    auto_show_delay_ms = 250,
                    -- The docs window can still show useful text without
                    -- spending Treesitter work on every popup.
                    treesitter_highlighting = false,
                },
            },
            sources = {
                per_filetype = {
                    text = {}, -- disabled
                    markdown = {}, -- disabled
                },
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
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
        },
        config = function(_, opts)
            require('blink.cmp').setup(opts)

            -- extend Neovim's client capabilities with the completion ones
            vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
        end,
    },
}
