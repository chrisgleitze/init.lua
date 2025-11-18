-- installation:
-- curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
-- chmod a+x phpactor.phar
-- mv phpactor.phar ~/.local/bin/phpactor

---@type vim.lsp.Config
return {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
    -- workspace_required = true,
    -- init_options = {
    --     ["language_server_phpstan.enabled"] = true,
    --     ["language_server_psalm.enabled"] = true,
    -- },
}
