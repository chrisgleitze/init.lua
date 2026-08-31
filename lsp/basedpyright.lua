-- basedpyright: Python type checker and navigation LSP

---@type vim.lsp.Config
return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyrightconfig.json',
        'pyproject.toml',
        'uv.lock',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        '.git',
    },
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'standard',
            },
        },
    },
}
