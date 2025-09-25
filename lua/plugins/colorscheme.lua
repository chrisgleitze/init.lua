return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            dark_variant = "main",
            styles = {
                italic = false,
            },
            groups = {
                background = "#0d0a0a",
            },
        })

        vim.cmd("colorscheme rose-pine-main")
    end,
}
