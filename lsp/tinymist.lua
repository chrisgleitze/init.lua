---@type vim.lsp.Config
return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/tinymist', 'lsp' },
    filetypes = { 'typst' },
    root_markers = { 'typst.toml', '.git' },
    settings = {
        formatterMode = 'typstyle',
        exportPdf = 'onSave',
        completion = {
            triggerSuggestAndParameterHints = true,
        },
    },
}
