return {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        -- {"3rd/image.nvim", opts = {}}, -- optional image support
    },
    opts = {
        filesystem = {
            follow_current_file = { enabled = true },
        },
        window = {
            width = 35,
        },
    },
    config = function(_, opts)
        local events = require('neo-tree.events')
        local define_autocmd_event = events.define_autocmd_event

        events.define_autocmd_event = function(event_name, autocmds, ...)
            if event_name == events.VIM_BUFFER_MODIFIED_SET then
                autocmds = { 'OptionSet modified' }
            end

            return define_autocmd_event(event_name, autocmds, ...)
        end

        require('neo-tree').setup(opts)
    end,
    keys = {
        vim.keymap.set('n', '<leader>t', '<Cmd>Neotree toggle<CR>'),
        vim.keymap.set('n', '<leader>T', '<Cmd>Neotree position=current toggle<CR>'),
    },
}
