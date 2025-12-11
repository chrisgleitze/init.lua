return {
    "sindrets/diffview.nvim",
    lazy = true,
    keys = {
        -- open diffview
        { "<leader>V", "<cmd>DiffviewOpen<cr>" },
        -- [g]it [h]istory of current file
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>" },
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
            -- stylua: ignore start
            keymaps = {
                -- close all the various diffviews with q in normal mode
                view = {
                    { "n", "<esc>",      actions.close                          },
                },
                file_history_panel = {
                    { "n", "<esc>",      "<cmd>DiffviewClose<cr>"               },
                },
                disable_defaults = true,
                file_panel = {
                    { "n", "<esc>",      "<cmd>DiffviewClose<cr>"               },
                    { 'n', 'j',          actions.next_entry,                    },
                    { 'n', 'k',          actions.prev_entry,                    },
                    { 'n', '<cr>',       actions.select_entry,                  },
                    { 'n', 's',          actions.toggle_stage_entry,            },
                    { 'n', 'S',          actions.stage_all,                     },
                    { 'n', 'U',          actions.unstage_all,                   },
                    { 'n', 'X',          actions.restore_entry,                 },
                    { 'n', 'L',          actions.open_commit_log,               },
                    { 'n', 'gf',         actions.goto_file_tab,                 },
                    { 'n', 'za',         actions.toggle_fold,                   },
                    { 'n', 'zR',         actions.open_all_folds,                },
                    { 'n', 'zM',         actions.close_all_folds,               },
                    { 'n', '<c-b>',      actions.scroll_view(-0.25),            },
                    { 'n', '<c-f>',      actions.scroll_view(0.25),             },
                    { 'n', '<tab>',      actions.select_next_entry,             },
                    { 'n', '<s-tab>',    actions.select_prev_entry,             },
                    { 'n', 'i',          actions.listing_style,                 },
                    { 'n', '[x',         actions.prev_conflict,                 },
                    { 'n', ']x',         actions.next_conflict,                 },
                    { 'n', '?',          actions.help('file_panel'),            },
                    { 'n', '<leader>GO', actions.conflict_choose_all('ours'),   },
                    { 'n', '<leader>GT', actions.conflict_choose_all('theirs'), },
                    { 'n', '<leader>GB', actions.conflict_choose_all('base'),   },
                    { 'n', '<leader>GA', actions.conflict_choose_all('all'),    },
                    { 'n', '<leader>GD', actions.conflict_choose_all('none'),   },
                    -- stylua: ignore end
                },
            },
        })
    end,
}
