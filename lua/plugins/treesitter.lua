return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts = {
        auto_install = true,
        sync_install = true,
        highlight = { enable = true },
        ensure_installed = {
            "all",
        },
    },
}
