local function fff(method, arg)
    return function()
        require('fff')[method](arg)
    end
end

return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
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
            -- border = 'rounded',
            flex = false,
        },
        preview = { line_numbers = true },
        keymaps = {
            close = { '<Esc>', '<C-c>' },
            move_up = { '<Up>', '<C-p>', '<C-k>' },
            move_down = { '<Down>', '<C-n>', '<C-j>' },
            preview_scroll_up = '<C-b>',
            preview_scroll_down = '<C-f>',
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
            '<leader>fid',
            fff('find_files_in_dir', vim.fn.expand('~/projects/dotfiles')),
            desc = '[f]ind [i]n neovim [d]otfiles',
        },
    },
}
