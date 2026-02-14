-- configure highlight effect
-- and additional features for yank command
return {
    'gbprod/yanky.nvim',
    event = { 'BufReadPre' },
    opts = {
        ring = { history_length = 20 },
        highlight = { timer = 40 },
    },
    keys = {
        { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
        { '=p', '<Plug>(YankyPutAfterLinewise)' },
        { '=P', '<Plug>(YankyPutBeforeLinewise)' },
    },
}
