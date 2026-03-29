-- CSS linter
-- install globally: npm install -g @stylelint/language-server

---@type vim.lsp.Config
return {
    cmd = { 'stylelint-language-server', '--stdio' },
    filetypes = {
        'astro',
        'css',
        'html',
        'less',
        'scss',
        'vue',
    },
    root_markers = {
        '.stylelintrc',
        '.stylelintrc.mjs',
        '.stylelintrc.cjs',
        '.stylelintrc.js',
        '.stylelintrc.json',
        '.stylelintrc.yaml',
        '.stylelintrc.yml',
        'stylelint.config.mjs',
        'stylelint.config.cjs',
        'stylelint.config.js',
    },
    settings = {
        stylelintplus = {
            -- lint on save instead of on type.
            validateOnSave = true,
            validateOnType = false,
        },
    },
}
