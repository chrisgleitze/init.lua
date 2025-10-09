-- CSS linter
-- install globally: npm i -g stylelint-lsp
-- install in project with recommended rules, creates stylelintrc file:
-- npm init stylelint

---@type vim.lsp.Config
return {
    cmd = { "stylelint-lsp", "--stdio" },
    filetypes = { "css", "less", "scss" },
    root_markers = { ".stylelintrc", ".stylelintrc.js", ".stylelintrc.json", "stylelint.config.js" },
    settings = {
        stylelintplus = {
            -- lint on save instead of on type.
            validateOnSave = true,
            validateOnType = false,
        },
    },
}
