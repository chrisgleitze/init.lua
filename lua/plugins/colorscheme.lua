return {

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

    -- "rose-pine/neovim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     require("rose-pine").setup({
    --         disable_background = true,
    --         styles = {
    --             italic = false,
    --         },
    --     })
    --
    --     vim.cmd.colorscheme("rose-pine")
    -- end,

    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        -- require("rose-pine").setup({
        --     disable_background = true,
        --     styles = {
        --         italic = false,
        --     },
        -- })

        vim.cmd.colorscheme("rose-pine")
    end,

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
