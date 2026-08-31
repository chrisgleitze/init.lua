-- cd into `nvim <dir>` so project-local commands start in that directory
local function startup_dir()
    local argv = vim.fn.argv()
    -- leave cwd unchanged for `nvim`, `nvim file`, or multiple arguments
    if #argv ~= 1 then
        return nil
    end

    local path = vim.fn.expand(argv[1])
    -- only directory arguments should become the working directory
    if vim.fn.isdirectory(path) == 0 then
        return nil
    end

    return vim.fn.fnamemodify(path, ':p')
end

local dir = startup_dir()
if dir ~= nil then
    vim.api.nvim_set_current_dir(dir)
end
