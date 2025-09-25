---@type vim.lsp.Config
return {
    cmd = { "phpactor", "language-server" },
    filetypes = {
        "php",
    },
    root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
    workspace_required = true,
    -- init_options = {
    --     ["language_server_phpstan.enabled"] = true,
    --     -- ["language_server_psalm.enabled"] = true,
    -- },
}
