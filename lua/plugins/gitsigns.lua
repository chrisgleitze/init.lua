return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
        },
        -- signs = {
        --     add = { text = "+" },
        --     change = { text = "~" },
        --     delete = { text = "_" },
        --     topdelete = { text = "‾" },
        --     changedelete = { text = "~" },
        -- },
        -- signs_staged = {
        --     add = { text = "+" },
        --     change = { text = "~" },
        --     delete = { text = "_" },
        --     topdelete = { text = "‾" },
        --     changedelete = { text = "~" },
        -- },
        -- preview_config = {
        --     border = "rounded",
        --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        -- },
    },
}
