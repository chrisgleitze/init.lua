-- ruff: Python lint, fix, format, and import-sort LSP

local root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'uv.lock' }
local home = vim.fs.normalize(vim.uv.os_homedir())

local function root_dir(bufnr, on_dir)
    local root = vim.fs.root(bufnr, root_markers)
    if not root then
        local name = vim.api.nvim_buf_get_name(bufnr)
        root = name ~= '' and vim.fs.dirname(name) or nil
    end
    if root and vim.fs.normalize(root) ~= home then
        on_dir(root)
    end
end

---@type vim.lsp.Config
return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_dir = root_dir,
}
