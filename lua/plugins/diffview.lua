local function diffview_hl()
    vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#12351f' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#451820' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffChange', { bg = '#2b2440' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffText', { bg = '#9a7a00' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffTextInline', { bg = '#9a7a00' })
end

local function setup()
    local actions = require('diffview.actions')

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
            disable_defaults = true,
            view = {
                { 'n', '<esc>', actions.close },
                { 'n', '<tab>', actions.select_next_entry },
                { 'n', '<s-tab>', actions.select_prev_entry },
                { 'n', 'gf', actions.goto_file_tab },
                { 'n', '<leader>gf', actions.focus_files },
                { 'n', '<leader>gr', actions.refresh_files },
                { 'n', 'g<C-x>', actions.cycle_layout },
                { 'n', '[x', actions.prev_conflict },
                { 'n', ']x', actions.next_conflict },
                { 'n', '<leader>co', actions.conflict_choose('ours') },
                { 'n', '<leader>ct', actions.conflict_choose('theirs') },
                { 'n', '<leader>cb', actions.conflict_choose('base') },
                { 'n', '<leader>ca', actions.conflict_choose('all') },
                { 'n', '<leader>cd', actions.conflict_choose('none') },
                { 'n', '<leader>cO', actions.conflict_choose_all('ours') },
                { 'n', '<leader>cT', actions.conflict_choose_all('theirs') },
                { 'n', '<leader>cB', actions.conflict_choose_all('base') },
            },
            file_panel = {
                { 'n', '<esc>', actions.close },
                { 'n', 'j', actions.next_entry },
                { 'n', 'k', actions.prev_entry },
                { 'n', '<cr>', actions.select_entry },
                { 'n', '<tab>', actions.select_next_entry },
                { 'n', '<s-tab>', actions.select_prev_entry },
                { 'n', 's', actions.toggle_stage_entry },
                { 'n', 'S', actions.stage_all },
                { 'n', 'U', actions.unstage_all },
                { 'n', 'X', actions.restore_entry },
                { 'n', 'i', actions.listing_style },
                { 'n', 'R', actions.refresh_files },
                { 'n', 'g?', actions.help('file_panel') },
                { 'n', '<leader>cO', actions.conflict_choose_all('ours') },
                { 'n', '<leader>cT', actions.conflict_choose_all('theirs') },
                { 'n', '<leader>cB', actions.conflict_choose_all('base') },
            },
            file_history_panel = {
                { 'n', '<esc>', actions.close },
                { 'n', 'j', actions.next_entry },
                { 'n', 'k', actions.prev_entry },
                { 'n', '<cr>', actions.select_entry },
                { 'n', 'g?', actions.help('file_history_panel') },
            },
        },
    })

    diffview_hl()
    vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('cg/diffview_highlights', { clear = true }),
        callback = diffview_hl,
    })
end

require('plugin_loader').on_command('diffview', 'Diffview*', setup)

vim.keymap.set('n', '<leader>Gm', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>Gx', '<cmd>DiffviewClose<cr>')
-- [g]it [H]istory of the whole repo
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>')
-- [g]it [h]istory of current file
vim.keymap.set('n', '<leader>gh', function()
    vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)))
end)
