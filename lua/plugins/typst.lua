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
    config = function(_, opts)
        require('typst-preview').setup(opts)

        -- The plugin syncs the preview on CursorMoved only, and only once the
        -- line number changes, so it stops following while typing and while
        -- moving within a line. Sync on every movement in both modes instead.
        -- A line change now syncs twice, here and in the plugin, which costs
        -- one redundant websocket write.
        local timer = assert(vim.uv.new_timer())
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = vim.api.nvim_create_augroup('cg/typst-preview', { clear = true }),
            pattern = '*.typ',
            callback = function()
                local preview = require('typst-preview')
                if not preview.get_follow_cursor() then
                    return
                end
                -- Restarting a running timer debounces held-down motions, so
                -- scrolling with j does not flood the preview server. The
                -- position is read when the timer fires, not now, hence the
                -- filetype guard against having left the buffer meanwhile.
                timer:start(
                    40,
                    0,
                    vim.schedule_wrap(function()
                        if vim.bo.filetype == 'typst' then
                            preview.sync_with_cursor()
                        end
                    end)
                )
            end,
        })
    end,
}
