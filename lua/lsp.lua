-- LSP
local M = {}
local map = vim.keymap.set

map('n', 'gd', function()
    require('fzf-lua').lsp_definitions({ jump1 = true })
end)
map('n', 'gD', function()
    require('fzf-lua').lsp_definitions({ jump1 = false })
end)
map('n', 'K', vim.lsp.buf.hover)
map('n', '<leader>vws', vim.lsp.buf.workspace_symbol)
map('n', '<leader>vca', vim.lsp.buf.code_action)
map('n', '<leader>vrr', vim.lsp.buf.references)
map('n', '<leader>vrn', vim.lsp.buf.rename)
map('n', '<leader>vsh', vim.lsp.buf.signature_help)
map('i', '<C-s>', vim.lsp.buf.signature_help)

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
    update_in_insert = true,
    severity_sort = true,
    float = {
        source = true,
    },
    virtual_text = true,
})

-- disable and enable diagnostics in current buffer
local function hide_diagnostics()
    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = false,
    })
end
local function show_diagnostics()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
    })
end
map('n', '<leader>dh', hide_diagnostics)
map('n', '<leader>ds', show_diagnostics)

-- diagnostic visuals
vim.diagnostic.config({
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

-- set up LSP servers
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()
        vim.lsp.enable(server_configs)
    end,
})

return M
