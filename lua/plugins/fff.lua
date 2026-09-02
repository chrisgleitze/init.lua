local function fff(method, arg)
    return function()
        require('fff')[method](arg)
    end
end

local function toggle_fff_preview()
    local ui = require('fff.picker_ui.picker_ui')
    local state = ui.state
    if not state.active or not state.config then
        return
    end
    state.config.preview.enabled = not state.config.preview.enabled
    ui.relayout()
end

return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary()
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
        local function set_fff_highlights()
            vim.api.nvim_set_hl(0, 'FFFNormal', { fg = '#e0def4', bg = '#191724' })
            vim.api.nvim_set_hl(0, 'FFFBorder', { fg = '#908caa', bg = '#191724' })
            vim.api.nvim_set_hl(0, 'FFFTitle', { fg = '#9ccfd8', bg = '#191724', bold = true })
            vim.api.nvim_set_hl(0, 'FFFPrompt', { fg = '#9ccfd8', bg = '#191724', bold = true })
            vim.api.nvim_set_hl(0, 'FFFCursorLine', { bg = '#312c49', bold = true })
            vim.api.nvim_set_hl(0, 'FFFGrepMatch', { fg = '#9ccfd8', bold = true })
        end
        set_fff_highlights()
        vim.api.nvim_create_autocmd('ColorScheme', {
            group = vim.api.nvim_create_augroup('cg/fff_highlights', { clear = true }),
            callback = set_fff_highlights,
        })

        -- disable grep tips and "No preview available"
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('fff_empty_state', { clear = true }),
            pattern = { 'fff_list', 'fff_preview' },
            callback = function(event)
                local buf = event.buf
                vim.api.nvim_buf_attach(buf, false, {
                    on_lines = vim.schedule_wrap(function()
                        if not vim.api.nvim_buf_is_valid(buf) then
                            return
                        end
                        local ft = vim.bo[buf].filetype
                        local lines = vim.api.nvim_buf_get_lines(buf, 0, 2, false)
                        if
                            ft == 'fff_list' and (lines[2] or ''):find('Start typing', 1, true)
                            or ft == 'fff_preview' and lines[1] == 'No preview available'
                        then
                            vim.bo[buf].modifiable = true
                            vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
                            vim.bo[buf].modifiable = false
                        end
                    end),
                })
            end,
        })
    end,
    opts = {
        prompt = vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.getcwd(), ':~')) .. '/',
        title = 'Files',
        wrap_around = true,
        layout = {
            height = 0.90,
            prompt_position = 'top',
            preview_position = 'bottom',
            preview_size = 0.45,
            flex = false,
        },
        preview = { line_numbers = true },
        hl = {
            normal = 'FFFNormal',
            border = 'FFFBorder',
            title = 'FFFTitle',
            prompt = 'FFFPrompt',
            cursor = 'FFFCursorLine',
            matched = 'FFFGrepMatch',
            grep_match = 'FFFGrepMatch',
            winhl = 'Normal:FFFNormal,FloatBorder:FFFBorder,FloatTitle:FFFTitle,CursorLine:FFFCursorLine',
        },
        grep = { enable_filename_constraint = true },
        keymaps = {
            close = { '<Esc>', '<C-c>' },
            move_up = { '<Up>', '<C-k>' },
            move_down = { '<Down>', '<C-j>' },
            preview_scroll_up = '<C-b>',
            preview_scroll_down = '<C-f>',
        },
        mappings = {
            i = { ['<C-i>'] = toggle_fff_preview, ['<Tab>'] = toggle_fff_preview },
            n = { ['<C-i>'] = toggle_fff_preview, ['<Tab>'] = toggle_fff_preview },
        },
    },
    keys = {
        { '<leader><leader>', fff('find_files'), desc = 'find files in project directory' },
        { '<leader>/', fff('live_grep'), desc = '(not fuzzy) find by grepping in project directory' },
        {
            '<leader>fg',
            fff('live_grep', { grep = { modes = { 'fuzzy' } } }),
            desc = 'fuzzy find by grepping in project directory',
        },
        {
            '<leader>fw',
            fff('live_grep_under_cursor'),
            desc = '[f]ind (grep) [v]isual selection or word under cursor',
            mode = { 'n', 'x' },
        },
        {
            '<leader>fW',
            function()
                require('fff').live_grep({ query = vim.fn.expand('<cWORD>') })
            end,
            desc = '[f]ind current [W]ORD',
        },
        { '<leader>fr', fff('resume'), desc = '[f]ind in [r]esumed search' },
        {
            '<leader>fc',
            function()
                local path = vim.fn.expand('%:.')
                if path == '' or vim.bo.buftype ~= '' or vim.bo.modified then
                    require('fzf-lua').lgrep_curbuf()
                    return
                end
                require('fff').live_grep({ query = path .. ' ' })
            end,
            desc = '[f]ind (grep) in [c]urrent buffer',
        },
        {
            '<leader>fid',
            fff('find_files_in_dir', vim.fn.expand('~/projects/dotfiles')),
            desc = '[f]ind [i]n neovim [d]otfiles',
        },
    },
}
