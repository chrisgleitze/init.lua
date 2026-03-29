-- CSS linter
-- install globally: npm install -g @stylelint/language-server

---@type vim.lsp.Config
return {
    cmd = { 'stylelint-language-server', '--stdio' },
    filetypes = { 'astro', 'css', 'html', 'less', 'scss', 'vue' },
    root_markers = { '.stylelintrc', '.stylelintrc.js', '.stylelintrc.json', 'stylelint.config.js' },
    settings = {
        stylelintplus = {
            -- lint on save instead of on type.
            validateOnSave = true,
            validateOnType = false,
        },
    },
}
