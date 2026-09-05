-- Local session management
-- Session files live in stdpath('state')/sessions/
local M = {}

local session_dir = vim.fn.stdpath('state') .. '/sessions/'
local enabled = true

local function normalize_dir(path)
    -- compare canonical directory strings so "~" and trailing slashes do not matter.
    return vim.fn.fnamemodify(vim.fn.expand(path), ':p'):gsub('([^/])/$', '%1')
end

local home = normalize_dir('~')
local tmp = normalize_dir('/tmp')

local function is_excluded()
    local cwd = normalize_dir(vim.fn.getcwd())
    -- exclude home/root exactly; exclude /tmp recursively.
    return cwd == home or cwd == '/' or cwd == tmp or cwd:sub(1, #tmp + 1) == tmp .. '/'
end

local function git_branch()
    local lines = vim.fn.systemlist({ 'git', 'branch', '--show-current' })
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return lines[1]
end

local function session_file(with_branch)
    local name = vim.fn.getcwd():gsub('[\\/:]+', '%%')
    if with_branch then
        -- keep separate sessions per git branch; main/master use the plain name
        local branch = git_branch()
        if branch and branch ~= '' and branch ~= 'main' and branch ~= 'master' then
            name = name .. '%%' .. branch:gsub('[\\/:]+', '%%')
        end
    end
    return session_dir .. name .. '.vim'
end

local function has_real_buffer()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted and vim.bo[buf].buftype == '' and vim.api.nvim_buf_get_name(buf) ~= '' then
            return true
        end
    end
    return false
end

local function list_sessions()
    local sessions = {}
    if vim.uv.fs_stat(session_dir) then
        for name, kind in vim.fs.dir(session_dir) do
            if kind == 'file' and name:sub(-4) == '.vim' then
                table.insert(sessions, name)
            end
        end
    end
    return sessions
end

local function source_session(file)
    if vim.fn.filereadable(file) == 0 then
        return false
    end
    vim.cmd('silent! source ' .. vim.fn.fnameescape(file))
    return true
end

function M.save()
    vim.fn.mkdir(session_dir, 'p')
    -- silent avoids hit-enter prompts from :mksession messages when quitting
    local ok, err = pcall(function()
        vim.cmd('silent mksession! ' .. vim.fn.fnameescape(session_file(true)))
    end)
    if not ok then
        vim.notify('Failed to save session: ' .. err, vim.log.levels.ERROR)
    end
end

-- load the session for the current directory, branch session first
function M.load()
    if is_excluded() then
        return
    end

    if not source_session(session_file(true)) then
        source_session(session_file(false))
    end
end

-- load the most recently saved session, regardless of directory
function M.load_last()
    local last, last_mtime
    for _, name in ipairs(list_sessions()) do
        local stat = vim.uv.fs_stat(session_dir .. name)
        if stat and (not last_mtime or stat.mtime.sec > last_mtime) then
            last, last_mtime = session_dir .. name, stat.mtime.sec
        end
    end

    if last then
        source_session(last)
    end
end

-- pick a session to load
function M.select()
    local sessions = list_sessions()
    table.sort(sessions)
    vim.ui.select(sessions, {
        prompt = 'Load session',
        format_item = function(name)
            return name:sub(1, -5):gsub('%%', '/')
        end,
    }, function(name)
        if name then
            source_session(session_dir .. name)
        end
    end)
end

-- stop => session won't be saved on exit
function M.stop()
    enabled = false
end

-- save once at least one real file buffer is open
local function should_save()
    return enabled and not is_excluded() and has_real_buffer()
end

vim.api.nvim_create_autocmd('VimLeavePre', {
    group = vim.api.nvim_create_augroup('cg/sessions', { clear = true }),
    callback = function()
        if should_save() then
            M.save()
        end
    end,
})

-- periodic save: a hard kill gives no signal, so VimLeavePre never runs
vim.uv.new_timer():start(
    60000,
    60000,
    vim.schedule_wrap(function()
        if should_save() then
            M.save()
        end
    end)
)

local map = vim.keymap.set
-- load the last session manually
map('n', '<leader>Qs', M.load_last)
-- select a session to load
map('n', '<leader>QS', M.select)
-- load the last session for the current directory
map('n', '<leader>Ql', M.load)
-- stop => session won't be saved on exit
map('n', '<leader>Qd', M.stop)

return M
