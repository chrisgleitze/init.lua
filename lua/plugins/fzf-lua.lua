return {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            fzf_colors = true,
            fzf_opts = {
                ["--no-scrollbar"] = false,
                ["--cycle"] = true,
                ["--ansi"] = true,
                ["--height"] = "100%",
                ["--highlight-line"] = true,
            },
            winopts = {
                preview = {
                    layout = "vertical",
                    -- default = "bat",
                },
            },
            defaults = {
                formatter = "path.dirname_first", -- show greyed-out directory before filename
            },
            keymap = {
                fzf = {
                    -- some keys don't work, likely due to this issue:
                    -- https://github.com/LazyVim/LazyVim/discussions/4029
                    -- https://www.reddit.com/r/neovim/comments/vfqseq/enable_special_keyboard_combinations_in_alacritty/
                    ["ctrl-k"] = "up",
                    ["ctrl-j"] = "down",
                    ["ctrl-b"] = "preview-page-up",
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-u"] = "half-page-up", -- in list of search results
                    ["ctrl-d"] = "half-page-down", -- in list of search results
                    ["ctrl-q"] = "abort",
                },
            },
        })
    end,
    keys = {
        {
            "<leader><leader>",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files in project directory",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Find by grepping in project directory",
        },
        {
            "<leader>fc",
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find in neovim configuration",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[F]ind current [W]ord",
        },
        {
            "<leader>fW",
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "[F]ind current [W]ORD",
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "[F]ind [D]iagnostics",
        },
        {
            "<leader>fo",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[F]ind [O]ld Files",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Find existing buffers",
        },
        {
            "<leader>fbg",
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "Live grep the current buffer",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "Find git status",
        },
        {
            "<leader>gc",
            function()
                require("fzf-lua").git_commits()
            end,
            desc = "Find git commits",
        },
        {
            "<leader>gbl",
            function()
                require("fzf-lua").git_blame()
            end,
            desc = "Find git blame",
        },
        {
            "<leader>gbr",
            function()
                require("fzf-lua").git_branches()
            end,
            desc = "Find git branches",
        },
    },
}
