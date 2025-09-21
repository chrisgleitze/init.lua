return {
    "folke/lazydev.nvim", -- fast, out-of-the-box LuaLS setup
    ft = "lua", -- only load on lua files
    opts = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
