-- LSP
local M = {}
local map = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('cg/lsp_keymaps', { clear = true }),
    callback = function(args)
        if vim.b[args.buf].lsp_keymaps_set then
            return
        end
        vim.b[args.buf].lsp_keymaps_set = true

        local function lsp_map(lhs, rhs)
            map('n', lhs, rhs, { buf = args.buf })
        end

        lsp_map('K', vim.lsp.buf.hover)
        lsp_map('<leader>vws', vim.lsp.buf.workspace_symbol)
        lsp_map('<leader>vca', vim.lsp.buf.code_action)
        lsp_map('<leader>vrr', vim.lsp.buf.references)
        lsp_map('<leader>vrn', vim.lsp.buf.rename)
        lsp_map('<leader>vsh', vim.lsp.buf.signature_help)
    end,
})

-- diagnostic keymaps
map('n', '<leader>vd', function()
    vim.diagnostic.open_float(nil, { border = 'rounded' })
end)
map('n', '[d', function()
    vim.diagnostic.jump({ float = { border = 'rounded' }, count = -1 })
end)
map('n', ']d', function()
    vim.diagnostic.jump({ float = { border = 'rounded' }, count = 1 })
end)

-- enable diagnostics by default
vim.diagnostic.enable(true)
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        border = 'rounded',
    },
    virtual_text = {
        prefix = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return '🭰× '
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return '🭰▲ '
            else
                return '🭰• '
            end
        end,
        suffix = '🭵',
    },
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ×',
            [vim.diagnostic.severity.WARN] = ' ▲',
            [vim.diagnostic.severity.HINT] = ' •',
            [vim.diagnostic.severity.INFO] = ' •',
        },
    },
})

local function show_buffer_diagnostics(bufnr, quiet)
    if quiet then
        vim.diagnostic.show(nil, bufnr, nil, {
            signs = true,
            underline = false,
            virtual_text = false,
        })
    else
        vim.diagnostic.show(nil, bufnr)
    end
end

-- hide and show inline diagnostics in current buffer, keeping signcolumn markers
local function hide_diagnostics()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.b[bufnr].diagnostics_quiet = true
    show_buffer_diagnostics(bufnr, true)
end
local function show_diagnostics()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.b[bufnr].diagnostics_quiet = false
    show_buffer_diagnostics(bufnr, false)
end
map('n', '<leader>dh', hide_diagnostics)
map('n', '<leader>ds', show_diagnostics)

vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = vim.api.nvim_create_augroup('cg/diagnostics_quiet', { clear = true }),
    callback = function(args)
        if vim.b[args.buf].diagnostics_quiet then
            show_buffer_diagnostics(args.buf, true)
        end
    end,
})

-- Keep LSP config loading lazy by enabling only servers that match the
-- current buffer's filetype.
local servers_by_ft = {
    astro = { 'emmet_ls', 'stylelint_lsp' },
    bash = { 'bashls' },
    blade = { 'intelephense' },
    c = { 'clangd' },
    cpp = { 'clangd' },
    css = { 'cssls', 'stylelint_lsp', 'tailwindcss' },
    cuda = { 'clangd' },
    eruby = { 'emmet_ls' },
    html = { 'html', 'emmet_ls', 'stylelint_lsp', 'tailwindcss' },
    htmlangular = { 'emmet_ls', 'tailwindcss' },
    htmldjango = { 'emmet_ls' },
    javascript = { 'tsgo', 'tailwindcss' },
    ['javascript.jsx'] = { 'tsgo', 'tailwindcss' },
    javascriptreact = { 'tsgo', 'emmet_ls', 'tailwindcss' },
    json = { 'jsonls' },
    jsonc = { 'jsonls' },
    less = { 'cssls', 'stylelint_lsp', 'tailwindcss' },
    lua = { 'lua_ls' },
    markdown = { 'tailwindcss' },
    mdx = { 'tailwindcss' },
    objc = { 'clangd' },
    objcpp = { 'clangd' },
    php = { 'intelephense', 'phpactor', 'tailwindcss' },
    pug = { 'emmet_ls' },
    sass = { 'emmet_ls', 'tailwindcss' },
    scss = { 'cssls', 'stylelint_lsp', 'tailwindcss' },
    sh = { 'bashls' },
    svelte = { 'emmet_ls', 'tailwindcss' },
    templ = { 'html', 'emmet_ls' },
    typst = { 'tinymist' },
    typescript = { 'tsgo', 'tailwindcss' },
    ['typescript.tsx'] = { 'tsgo', 'tailwindcss' },
    typescriptreact = { 'tsgo', 'emmet_ls', 'tailwindcss' },
    vue = { 'emmet_ls', 'stylelint_lsp', 'tailwindcss' },
    yaml = { 'yamlls' },
}

-- Enable only configs relevant to the current filetype, so JSON/YAML schema
-- setup and other server configs are not loaded by the first unrelated buffer.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('cg/lsp_enable_by_filetype', { clear = true }),
    callback = function(args)
        -- Filetype is the first filter: configs that do not apply to this
        -- buffer are never resolved or loaded.
        local servers = servers_by_ft[vim.bo[args.buf].filetype]
        if not servers then
            return
        end

        -- Match the Treesitter bigfile guard: skip expensive language servers
        -- for buffers where interactive editing should stay lightweight.
        if require('bigfile').is_big(args.buf) then
            return
        end

        -- vim.lsp.enable() is global, so avoid re-enabling servers that were
        -- already activated by an earlier buffer.
        local to_enable = {}
        for _, server in ipairs(servers) do
            if not vim.lsp.is_enabled(server) then
                table.insert(to_enable, server)
            end
        end

        if #to_enable > 0 then
            vim.lsp.enable(to_enable)
        end
    end,
})

return M
