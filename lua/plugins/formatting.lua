-- Formatting
-- Prefer the Prettier daemon when installed; fall back to regular prettier so
-- formatting still works on machines without prettierd.
local prettier = { 'prettierd', 'prettier', stop_after_first = true }

local function format_on_save(bufnr)
    -- Keep save latency predictable for large files; format those manually.
    if vim.api.nvim_buf_line_count(bufnr) > 5000 then
        return
    end

    local filename = vim.api.nvim_buf_get_name(bufnr)
    local stat = filename ~= '' and vim.uv.fs_stat(filename) or nil
    if stat and stat.size > 1024 * 1024 then
        return
    end

    return {
        -- Keep the save path short. If a formatter is slower than this, it is
        -- better surfaced as an explicit formatting action.
        timeout_ms = 700,
        lsp_format = 'fallback',
    }
end

return {
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        formatters_by_ft = {
            c = { 'clang-format' },
            cpp = { 'clang-format' },
            css = prettier,
            html = prettier,
            json = prettier,
            jsonc = prettier,
            javascript = prettier,
            javascriptreact = prettier,
            less = prettier,
            lua = { 'stylua' },
            markdown = prettier,
            -- see intelephense config for php formatting
            scss = prettier,
            sh = { 'shfmt' },
            typescript = prettier,
            typescriptreact = prettier,
            yaml = prettier,
        },
        formatters = {
            ['clang-format'] = {
                prepend_args = { '-style=file', '-fallback-style=LLVM' },
            },
        },
        format_on_save = format_on_save,
    },
}
