return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    -- cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>" },
        { "<leader>gB", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>" },
        -- open and close diffview
        vim.keymap.set("n", "<leader>V", function()
            if next(require("diffview.lib").views) == nil then
                vim.cmd("DiffviewOpen")
            else
                vim.cmd("DiffviewClose")
            end
        end),
    },
    config = function()
        local actions = require("diffview.actions")

        require("diffview").setup({
            enhanced_diff_hl = true,
            use_icons = true,
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
