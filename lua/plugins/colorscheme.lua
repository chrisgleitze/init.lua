return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            -- variant = "main",
            dark_variant = "main",
            styles = {
                italic = false,
            },
            groups = {
                background = "#0d0a0a",
                -- panel = "#0d0a0a",
                -- panel = "#141415",

                --     border = "muted",
                --     link = "iris",
                --     panel = "surface",
                --
                --     error = "love",
                --     hint = "iris",
                --     info = "foam",
                --     note = "pine",
                --     todo = "rose",
                --     warn = "gold",
                --
                --     git_add = "love",
                --     git_change = "love",
                --     git_delete = "love",
                --     git_dirty = "rose",
                --     git_ignore = "muted",
                --     git_merge = "iris",
                --     git_rename = "pine",
                --     git_stage = "iris",
                --     git_text = "rose",
                --     git_untracked = "subtle",
                --
                --     h1 = "iris",
                --     h2 = "foam",
                --     h3 = "rose",
                --     h4 = "gold",
                --     h5 = "pine",
                --     h6 = "foam",
            },
        })

        vim.cmd("colorscheme rose-pine-main")
    end,

    -- "projekt0n/github-nvim-theme",
    -- name = "github-theme",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("github_dark_default")
    -- end,

    -- "ellisonleao/gruvbox.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     vim.cmd("gruvbox")
    -- end,

    -- "folke/tokyonight.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     vim.cmd.colorscheme("tokyonight-night")
    -- end,

    -- "marko-cerovac/material.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     vim.cmd.colorscheme("material")
    -- end,
}
