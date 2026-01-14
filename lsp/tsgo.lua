-- npm i -g @typescript/native-preview

---@type vim.lsp.Config
return {
    cmd = { 'tsgo', '--lsp', '--stdio' },
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
