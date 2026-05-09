-- npm i -g @typescript/native-preview

local tsgo_bin = vim.fn.stdpath('data') .. '/mason/bin/tsgo'

if vim.fn.executable(tsgo_bin) == 0 then
    return {
        enabled = false,
    }
end

---@type vim.lsp.Config
return {
    cmd = { tsgo_bin, '--lsp', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = {
        'tsconfig.json',
        'tsconfig.base.json',
        'jsconfig.json',
        'package.json',
        'package-lock.json',
        'yarn.lock',
        'pnpm-lock.yaml',
        'bun.lock',
        'bun.lockb',
        '.git',
    },
    enabled = true,
}
