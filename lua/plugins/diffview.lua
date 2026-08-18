return {
    'dlyongemallo/diffview.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    keys = {
        -- open diff[V]iew
        { '<leader>V', '<cmd>DiffviewOpen<cr>' },
        -- [g]it [H]istory of the whole repo
        { '<leader>gH', '<cmd>DiffviewFileHistory<cr>' },
        -- [g]it [h]istory of current file
        {
            '<leader>gh',
            function()
                vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)))
            end,
        },
    },
    config = function()
        local actions = require('diffview.actions')
        local function diffview_hl()
            vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#12351f' })
            vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#451820' })
            vim.api.nvim_set_hl(0, 'DiffviewDiffChange', { bg = '#2b2440' })
            vim.api.nvim_set_hl(0, 'DiffviewDiffText', { bg = '#9a7a00' })
            vim.api.nvim_set_hl(0, 'DiffviewDiffTextInline', { bg = '#9a7a00' })
        end

        require('diffview').setup({
            enhanced_diff_hl = true,
            use_icons = true,
            show_help_hints = true,
            icons = {
                folder_closed = '',
                folder_open = '',
            },
            signs = {
                fold_closed = '',
                fold_open = '',
            },
            file_panel = {
                listing_style = 'tree',
                win_config = {
                    position = 'left',
                    width = 35,
                },
            },
            view = {
                default = {
                    layout = 'diff2_horizontal',
                    disable_diagnostics = false,
                    winbar_info = false,
                },
                merge_tool = {
                    layout = 'diff3_horizontal',
                    disable_diagnostics = false,
                    winbar_info = true,
                },
                file_history = {
                    layout = 'diff2_horizontal',
                    disable_diagnostics = true,
                    winbar_info = false,
                },
            },
            keymaps = {
                view = {
                    { 'n', '<esc>', actions.close },
                },
                file_history_panel = {
                    { 'n', '<esc>', '<cmd>DiffviewClose<cr>' },
                },
                file_panel = {
                    { 'n', '<esc>', '<cmd>DiffviewClose<cr>' },
                },
            },
        })

        diffview_hl()
        vim.api.nvim_create_autocmd('ColorScheme', { callback = diffview_hl })
    end,
}
