-- File Picker
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
                height = 0.90,
                width = 0.80,
                preview = {
                    layout = "vertical",
                },
            },
            defaults = {
                -- show greyed-out directory before filename
                formatter = "path.dirname_first",
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
        {
            -- Alt-h toggles hidden files in search results on/off
            "<leader><leader>",
            function()
                require("fzf-lua").files()
            end,
            desc = "find files in project directory",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "(not fuzzy) find by grepping in project directory",
        },
        {
            "<leader>fp",
            function()
                require("fzf-lua").grep()
            end,
            desc = "fuzzy find by using ripgrep in project directory",
        },
        {
            "<leader>fc",
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "[f]ind (grep) in [c]urrent buffer",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "[f]ind in [r]esumed search",
        },
        {
            "<leader>fu",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[f]ind open b[u]ffers",
            -- delete buffer in search results with C-x
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[f]ind current [w]ord",
        },
        {
            "<leader>fW",
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "[f]ind current [W]ORD",
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "[f]ind [d]iagnostics",
        },
        {
            "<leader>fo",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[f]ind [o]ld files",
        },
        {
            "<leader>fa",
            function()
                require("fzf-lua").autocmds()
            end,
            desc = "[f]ind [a]utocommands",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "find [g]it [s]tatus",
        },
        {
            "<leader>gc",
            function()
                require("fzf-lua").git_commits()
            end,
            desc = "find [g]it [c]ommits",
        },
        {
            "<leader>gbl",
            function()
                require("fzf-lua").git_blame()
            end,
            desc = "find [g]it [bl]ame",
        },
        {
            "<leader>gbr",
            function()
                require("fzf-lua").git_branches()
            end,
            desc = "find [g]it [br]anches",
        },
        {
            "<leader>fv",
            function()
                require("fzf-lua").nvim_options()
            end,
            desc = "[f]ind [o]ld files",
        },
        {
            "<leader>vh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "[v]iew/search Neovim [h]elp",
        },
        {
            "<leader>fig",
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "find in neovim con[fig]uration",
        },
    },
}
