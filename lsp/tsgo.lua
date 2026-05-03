-- npm i -g @typescript/native-preview

local tsgo_package = vim.fn.stdpath('data') .. '/mason/packages/tsgo/node_modules/@typescript/native-preview'
local tsgo_js = tsgo_package .. '/bin/tsgo.js'
local native_tsgo = vim.fn.stdpath('data') .. '/mason/packages/tsgo/node_modules/@typescript/native-preview-linux-x64/lib/tsgo'

if vim.fn.filereadable(tsgo_js) == 0 or vim.fn.executable(native_tsgo) == 0 then
    return {
        enabled = false,
    }
end

---@type vim.lsp.Config
return {
    cmd = { 'node', tsgo_js, '--lsp', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = {
        '.git',
        'jsconfig.json',
        'tsconfig.json',
        'tsconfig.base.json',
        'package.json',
        'package-lock.json',
        'yarn.lock',
        'pnpm-lock.yaml',
        'bun.lock',
        'bun.lockb',
    },
    enabled = true,
}
