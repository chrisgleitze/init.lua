return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
        require("github-theme").setup({
            palettes = {
                bg1 = "#FF0000",
            },
        })

        vim.cmd("colorscheme github_dark_default")
    end,
}
