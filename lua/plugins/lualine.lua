return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        sections = {
            lualine_x = { "filetype" },
        },
    },
}
