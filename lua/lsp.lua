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
            map('n', lhs, rhs, { buffer = args.buf })
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
        enabled = true,
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

-- set up LSP servers
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local config_lsp_dir = vim.fn.stdpath('config') .. '/lsp'
        local server_configs = {}

        for name, file_type in vim.fs.dir(config_lsp_dir) do
            if file_type == 'file' and name:match('%.lua$') then
                local server_name = name:gsub('%.lua$', '')
                table.insert(server_configs, server_name)
            end
        end

        table.sort(server_configs)
        vim.lsp.enable(server_configs)
    end,
})

return M
