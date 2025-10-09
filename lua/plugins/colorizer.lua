return {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        user_default_options = {
            tailwind = true,
            css = true,
            names = false,
            mode = "background",
        },
        filetypes = {
            "css",
            "scss",
            "html",
            "javascript",
            "typescript",
            "json",
            "jsonc",
            "lua",
            "yaml",
        },
    },
}
