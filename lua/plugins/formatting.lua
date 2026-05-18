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
    lazy = true,
    cmd = 'ConformInfo',
    init = function()
        -- Register format-on-save without loading conform.nvim during startup.
        -- The first save loads Conform only if the file is small enough to format.
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('cg/conform_format_on_save', { clear = true }),
            callback = function(args)
                local format_opts = format_on_save(args.buf)
                if not format_opts then
                    return
                end

                format_opts.bufnr = args.buf
                require('conform').format(format_opts)
            end,
        })
    end,
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
    },
}
