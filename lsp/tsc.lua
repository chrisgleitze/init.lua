-- npm install -g typescript@latest

local tsc_bin = vim.fn.stdpath('data') .. '/mason/bin/tsc'

if vim.fn.executable(tsc_bin) == 0 then
    return {
        enabled = false,
    }
end

---@type vim.lsp.Config
return {
    cmd = { tsc_bin, '--lsp', '--stdio' },
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
