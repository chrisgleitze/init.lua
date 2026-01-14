-- Debian/Ubuntu:
-- mac: brew install lua-language-server

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.emmyrc.json',
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = {
                globals = { 'vim' },
            },
            format = { enable = false }, -- use stylua via conform.nvim instead
            hint = {
                enable = true,
                arrayIndex = 'Disable',
            },
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                },
            },
        },
    },
}
