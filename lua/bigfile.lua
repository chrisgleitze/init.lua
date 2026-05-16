local M = {}

-- Shared cutoff values for features that are useful on normal files but can
-- make very large or minified files feel sluggish.
local max_size = 1.5 * 1024 * 1024
local max_line_length = 1000
local sample_lines = 200

function M.is_big(bufnr)
    bufnr = bufnr or 0

    -- Cache the decision per buffer so FileType autocmds and later feature
    -- checks do not keep touching the filesystem or scanning lines.
    if vim.b[bufnr].cg_bigfile ~= nil then
        return vim.b[bufnr].cg_bigfile
    end

    -- A file-size check is the cheapest signal and catches logs, generated
    -- assets, dumps, and other files that tend to punish parsers and LSPs.
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local stat = filename ~= '' and vim.uv.fs_stat(filename) or nil
    if stat and stat.size > max_size then
        vim.b[bufnr].cg_bigfile = true
        return true
    end

    -- Long lines are common in minified output. Sample only the beginning of
    -- the file so the guard itself stays cheap.
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local line_limit = math.min(line_count, sample_lines)
    local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, 0, line_limit, false)
    if ok then
        for _, line in ipairs(lines) do
            if #line > max_line_length then
                vim.b[bufnr].cg_bigfile = true
                return true
            end
        end
    end

    -- Mark normal files explicitly too; nil means "not checked yet".
    vim.b[bufnr].cg_bigfile = false
    return false
end

return M
