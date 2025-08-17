return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    keys = {
        -- [g]it [h]istory of current file
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>" },
        -- open diffview
        { "<leader>V", "<cmd>DiffviewOpen<cr>" },
    },
    config = function()
        local actions = require("diffview.actions")
        require("diffview").setup({
            enhanced_diff_hl = true,
            use_icons = true,
            show_help_hints = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
            },
            file_panel = {
                listing_style = "tree",
                win_config = {
                    position = "left",
                    width = 35,
                },
            },
            view = {
                default = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = false,
                    winbar_info = false,
                },
                merge_tool = {
                    layout = "diff3_horizontal",
                    disable_diagnostics = false,
                    winbar_info = true,
                },
                file_history = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = true,
                    winbar_info = false,
                },
            },
            keymaps = {
                -- close all the various diffviews with q in normal mode
                view = {
                    { "n", "q", actions.close },
                },
                file_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>" },
                },
                file_history_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>" },
                },
            },
        })
    end,
}
