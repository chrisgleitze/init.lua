return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        keymaps = {
            vim.keymap.set("n", "<leader>Me", function()
                require("render-markdown").buf_enable()
            end),
            vim.keymap.set("n", "<leader>Md", function()
                require("render-markdown").buf_disable()
            end),
        },
    },
}
