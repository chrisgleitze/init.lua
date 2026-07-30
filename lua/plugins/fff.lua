return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        return {
            prompt = vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.getcwd(), ':~')) .. '/',
            title = 'Files',
            wrap_around = true,
            layout = {
                height = 0.90,
                width = 0.80,
                prompt_position = 'top',
                preview_position = 'bottom',
                preview_size = 0.45,
                border = 'rounded',
                flex = false,
                show_scrollbar = true,
            },
            preview = {
                line_numbers = true,
            },
            keymaps = {
                close = { '<Esc>', '<C-c>' },
                move_up = { '<Up>', '<C-p>', '<C-k>' },
                move_down = { '<Down>', '<C-n>', '<C-j>' },
                preview_scroll_up = '<C-b>',
                preview_scroll_down = '<C-f>',
            },
        }
    end,
    keys = {
        {
            '<leader><leader>',
            function()
                require('fff').find_files()
            end,
            desc = 'find files in project directory',
        },
        {
            '<leader>/',
            function()
                require('fff').live_grep()
            end,
            desc = '(not fuzzy) find by grepping in project directory',
        },
        {
            '<leader>fg',
            function()
                require('fff').live_grep({ grep = { modes = { 'fuzzy' } } })
            end,
            desc = 'fuzzy find by grepping in project directory',
        },
        {
            '<leader>fv',
            function()
                require('fff').live_grep_under_cursor()
            end,
            desc = '[f]ind (grep) [v]isual selection in project',
            mode = 'x',
        },
        {
            '<leader>fw',
            function()
                require('fff').live_grep_under_cursor()
            end,
            desc = '[f]ind current [w]ord',
        },
        {
            '<leader>fW',
            function()
                require('fff').live_grep({ query = vim.fn.expand('<cWORD>') })
            end,
            desc = '[f]ind current [W]ORD',
        },
        {
            '<leader>fr',
            function()
                require('fff').resume()
            end,
            desc = '[f]ind in [r]esumed search',
        },
        {
            '<leader>fid',
            function()
                require('fff').find_files_in_dir(vim.fn.expand('~/projects/dotfiles'))
            end,
            desc = '[f]ind [i]n neovim [d]otfiles',
        },
    },
}
