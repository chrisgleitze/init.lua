return {
    'alexghergh/nvim-tmux-navigation',
    event = 'BufReadPre',
    config = function()
        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup({
            disable_when_zoomed = true, -- defaults to false
        })

        local set = vim.keymap.set

        -- navigate tmux splits with Ctrl - Vim arrow navigation
        set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
        set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
        set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
        set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
        set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
        set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
}
