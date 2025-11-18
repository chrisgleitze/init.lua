-- installs both typescript and ts_ls:
-- npm install -g typescript typescript-language-server

---@type vim.lsp.Config
return {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = {
        enable = true,
        lint = true,
    },
    filetypes = {
        "vue",
        "javascript",
        "typescript",
        "javascriptreact",
        "javascript.jsx",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "bun.lockb",
        "bun.lock",
        "deno.lock",
    },
}
