-- ruff: Python lint, fix, format, and import-sort LSP

---@type vim.lsp.Config
return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'uv.lock', '.git' },
}
