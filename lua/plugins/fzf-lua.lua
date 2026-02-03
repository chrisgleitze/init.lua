-- File Picker
return {
    'ibhagwan/fzf-lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('fzf-lua').setup({
            fzf_colors = true,
            fzf_opts = {
                ['--no-scrollbar'] = false,
                ['--cycle'] = true,
                ['--ansi'] = true,
                ['--height'] = '100%',
                ['--highlight-line'] = true,
            },
            defaults = {
                formatter = 'path.dirname_first', -- show greyed-out directory before filename
            },
            winopts = {
                height = 0.90,
                width = 0.80,
                preview = {
                    layout = 'vertical',
                },
            },
            keymap = {
                fzf = {
                    -- couldn't make the Alt key work, likely due to this issue:
                    -- https://github.com/LazyVim/LazyVim/discussions/4029
                    -- https://www.reddit.com/r/neovim/comments/vfqseq/enable_special_keyboard_combinations_in_alacritty/
                    ['ctrl-k'] = 'up',
                    ['ctrl-j'] = 'down',
                    ['ctrl-b'] = 'preview-page-up',
                    ['ctrl-f'] = 'preview-page-down',
                    ['ctrl-u'] = 'half-page-up', -- in list of search results
                    ['ctrl-d'] = 'half-page-down', -- in list of search results
                    ['ctrl-c'] = 'abort',
                },
            },
        })
    end,
    keys = {
        -- Alt-h toggles hidden files in search results on/off
        { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'find files in project directory' },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = '(not fuzzy) find by grepping in project directory' },
        { '<leader>fg', '<cmd>FzfLua grep<cr>', desc = 'fuzzy find by using ripgrep in project directory' },
        { '<leader>fc', '<cmd>FzfLua lgrep_curbuf<cr>', desc = '[f]ind (grep) in [c]urrent buffer' },
        {
            '<leader>fv',
            '<cmd>FzfLua grep_visual<cr>',
            desc = '[f]ind (grep) [v]isual selection in project',
            mode = 'x',
        },
        { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = '[f]ind current [w]ord' },
        { '<leader>fW', '<cmd>FzfLua grep_cWORD<cr>', desc = '[f]ind current [W]ORD' },
        { '<leader>fr', '<cmd>FzfLua resume<cr>', desc = '[f]ind in [r]esumed search' },
        { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = '[f]ind open b[u]ffers' },
        { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', desc = '[f]ind [d]iagnostics' },
        { '<leader>fo', '<cmd>FzfLua oldfiles<cr>', desc = '[f]ind [o]ld files' },
        { '<leader>fa', '<cmd>FzfLua autocmds<cr>', desc = '[f]ind [a]utocommands' },
        { '<leader>gs', '<cmd>FzfLua git_status<cr>', desc = 'find [g]it [s]tatus' },
        { '<leader>gc', '<cmd>FzfLua git_commits<cr>', desc = 'find [g]it [c]ommits' },
        { '<leader>gC', '<cmd>FzfLua git_bcommits<cr>', desc = 'find [g]it [c]ommits in current buffer' },
        { '<leader>gbl', '<cmd>FzfLua git_blame<cr>', desc = 'find [g]it [bl]ame' },
        { '<leader>gbr', '<cmd>FzfLua git_branches<cr>', desc = 'find [g]it [br]anches' },
        { '<leader>fO', '<cmd>FzfLua nvim_options<cr>', desc = '[f]ind [o]ld files' },
        { '<leader>vh', '<cmd>FzfLua helptags<cr>', desc = '[v]iew/search Neovim [h]elp' },
        {
            '<leader>fig',
            function()
                require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
            end,
            desc = 'find in neovim con[fig]uration',
        },
        {
            '<C-x><C-f>',
            function()
                require('fzf-lua').complete_path({
                    winopts = {
                        height = 0.4,
                        width = 0.5,
                        relative = 'cursor',
                    },
                })
            end,
            mode = 'i',
            desc = 'fuzzy complete path',
        },
        -- { "<leader>ft", "<cmd>FzfLua undotree<cr>", desc = "Undotree" },
    },
}
