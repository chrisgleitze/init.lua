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
                -- fullscreen = "true",
                height = 0.90,
                width = 0.80,
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
                    -- couldn't make the Alt key work, likely due to this issue:
                    -- https://github.com/LazyVim/LazyVim/discussions/4029
                    -- https://www.reddit.com/r/neovim/comments/vfqseq/enable_special_keyboard_combinations_in_alacritty/
                    ["ctrl-k"] = "up",
                    ["ctrl-j"] = "down",
                    ["ctrl-b"] = "preview-page-up",
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-u"] = "half-page-up", -- in list of search results
                    ["ctrl-d"] = "half-page-down", -- in list of search results
                    ["ctrl-c"] = "abort",
                },
            },
        })
    end,
    keys = {
        -- Alt-h toggles hidden files in search results on/off
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
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "[Find] in [r]esumed search",
        },
        {
            "<leader>fs",
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "[F]ind (grep) in current buffer",
        },
        {
            "<leader>fu",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[F]ind open b[u]ffers",
            -- delete buffer in search results with C-x
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[F]ind current [w]ord",
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
            desc = "[F]ind [d]iagnostics",
        },
        {
            "<leader>fo",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[F]ind [o]ld Files",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "Find [g]it [s]tatus",
        },
        {
            "<leader>gc",
            function()
                require("fzf-lua").git_commits()
            end,
            desc = "Find [g]it [c]ommits",
        },
        {
            "<leader>gbl",
            function()
                require("fzf-lua").git_blame()
            end,
            desc = "Find [g]it [bl]ame",
        },
        {
            "<leader>gbr",
            function()
                require("fzf-lua").git_branches()
            end,
            desc = "Find [g]it [br]anches",
        },
        {
            "<leader>vh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Search in Neovim help manual",
        },
        {
            "<leader>fig",
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find in neovim con[fig]uration",
        },
    },
}
