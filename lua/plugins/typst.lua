return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
        invert_colors = 'auto',
    },
    keys = {
        { '<leader>yp', '<cmd>TypstPreviewToggle<cr>' },
        { '<leader>yc', '<cmd>TypstPreviewSyncCursor<cr>' },
        { '<leader>yf', '<cmd>TypstPreviewFollowCursorToggle<cr>' },
    },
}
