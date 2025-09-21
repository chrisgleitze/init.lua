---@type vim.lsp.Config
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "css",
        "sass",
        "scss",
        "less",
        "html",
        "htmlangular",
        "javascript",
        "javascriptreact",
        "markdown",
        "mdx",
        "php",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
    },
    root_markers = {
        -- Generic
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "postcss.config.mjs",
        "postcss.config.ts",
        -- Django
        "theme/static_src/tailwind.config.js",
        "theme/static_src/tailwind.config.cjs",
        "theme/static_src/tailwind.config.mjs",
        "theme/static_src/tailwind.config.ts",
        "theme/static_src/postcss.config.js",
        -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
        ".git",
    },
}
