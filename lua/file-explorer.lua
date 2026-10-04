local api = vim.api
local map = vim.keymap.set
local sep = package.config:sub(1, 1)

local pending

local function notify(message, level)
    vim.notify(message, level or vim.log.levels.INFO)
end

local function reload(buf)
    if api.nvim_buf_is_valid(buf) then
        require('nvim.dir')._reload(buf)
    end
end

local function entry(buf)
    local name = api.nvim_get_current_line():gsub('%z', '\n')
    if name == '' then
        return
    end

    if name:sub(-1) == '/' then
        name = name:sub(1, -2)
    end

    local directory = api.nvim_buf_get_name(buf)
    return name, vim.fs.joinpath(directory, name)
end

local function valid_name(name)
    return name ~= '' and name ~= '.' and name ~= '..' and not name:find('[/\\]')
end

local function prompt_name(prompt, callback, default)
    vim.ui.input({ prompt = prompt, default = default }, function(name)
        if name and valid_name(name) then
            callback(name)
        elseif name and name ~= '' then
            notify('Use a name without path separators', vim.log.levels.ERROR)
        end
    end)
end

local function create_file(buf)
    local directory = api.nvim_buf_get_name(buf)
    prompt_name('New file: ', function(name)
        local path = vim.fs.joinpath(directory, name)
        local fd, err = vim.uv.fs_open(path, 'wx', 420)
        if not fd then
            notify('Could not create ' .. name .. ': ' .. err, vim.log.levels.ERROR)
            return
        end
        vim.uv.fs_close(fd)
        reload(buf)
    end)
end

local function create_folder(buf)
    local directory = api.nvim_buf_get_name(buf)
    prompt_name('New folder: ', function(name)
        local path = vim.fs.joinpath(directory, name)
        local ok, err = vim.uv.fs_mkdir(path, 493)
        if not ok then
            notify('Could not create ' .. name .. ': ' .. err, vim.log.levels.ERROR)
            return
        end
        reload(buf)
    end)
end

local function delete(buf)
    local name, path = entry(buf)
    if not path then
        return
    end

    vim.ui.select({ 'Delete', 'Cancel' }, { prompt = 'Delete ' .. name .. '?' }, function(choice)
        if choice ~= 'Delete' then
            return
        end

        if vim.fn.delete(path, 'rf') ~= 0 then
            notify('Could not delete ' .. name, vim.log.levels.ERROR)
            return
        end
        reload(buf)
    end)
end

local function rename(buf)
    local name, path = entry(buf)
    if not path then
        return
    end

    prompt_name('Rename to: ', function(new_name)
        local destination = vim.fs.joinpath(vim.fs.dirname(path), new_name)
        if vim.uv.fs_lstat(destination) then
            notify('Already exists: ' .. new_name, vim.log.levels.ERROR)
            return
        end
        if vim.fn.rename(path, destination) ~= 0 then
            notify('Could not rename ' .. name, vim.log.levels.ERROR)
            return
        end
        reload(buf)
    end, name)
end

local function mark(buf, kind)
    local name, path = entry(buf)
    if not path then
        return
    end

    pending = { kind = kind, path = path }
    notify(('Marked for %s: %s'):format(kind, name))
end

local function copy_tree(source, destination)
    local stat, err = vim.uv.fs_lstat(source)
    if not stat then
        error(err)
    end

    if stat.type == 'directory' then
        if vim.fn.mkdir(destination) == 0 then
            error('could not create ' .. destination)
        end

        local handle = assert(vim.uv.fs_scandir(source))
        while true do
            local name = vim.uv.fs_scandir_next(handle)
            if not name then
                break
            end
            copy_tree(source .. sep .. name, destination .. sep .. name)
        end
        return
    end

    if stat.type ~= 'file' then
        error('unsupported file type: ' .. stat.type)
    end

    local ok, copy_err = vim.uv.fs_copyfile(source, destination)
    if not ok then
        error(copy_err)
    end
end

local function is_inside(path, directory)
    return path == directory or path:sub(1, #directory + 1) == directory .. sep
end

local function paste(buf)
    if not pending then
        return
    end

    local source = pending.path
    local source_name = vim.fs.basename(source)
    local directory = api.nvim_buf_get_name(buf)
    local destination = vim.fs.joinpath(directory, source_name)
    local operation = pending.kind

    local source_stat = vim.uv.fs_lstat(source)
    if not source_stat then
        notify('Source no longer exists: ' .. source_name, vim.log.levels.ERROR)
        pending = nil
        return
    end
    if source_stat.type == 'directory' and is_inside(destination, source) then
        notify('Cannot paste a directory into itself', vim.log.levels.ERROR)
        return
    end
    if vim.uv.fs_lstat(destination) then
        notify('Already exists: ' .. source_name, vim.log.levels.ERROR)
        return
    end

    local ok, err = pcall(function()
        if operation == 'move' then
            if vim.fn.rename(source, destination) ~= 0 then
                error('move failed')
            end
        else
            copy_tree(source, destination)
        end
    end)

    if not ok then
        notify(('Could not %s %s: %s'):format(operation, source_name, err), vim.log.levels.ERROR)
        return
    end

    pending = nil
    reload(buf)
end

local function setup_buffer(buf)
    local opts = { buffer = buf, silent = true }
    map('n', 'd', function()
        delete(buf)
    end, opts)
    map('n', 'm', function()
        mark(buf, 'move')
    end, opts)
    map('n', 'r', function()
        rename(buf)
    end, opts)
    map('n', 'y', function()
        mark(buf, 'copy')
    end, opts)
    map('n', 'p', function()
        paste(buf)
    end, opts)
    map('n', 'N', function()
        create_folder(buf)
    end, opts)
    map('n', 'n', function()
        create_file(buf)
    end, opts)
end

api.nvim_create_autocmd('FileType', {
    pattern = 'directory',
    callback = function()
        setup_buffer(api.nvim_get_current_buf())
    end,
})

local function edit_directory(path)
    api.nvim_cmd({
        cmd = 'edit',
        args = { path },
        magic = { file = false, bar = false },
    }, {})
end

map('n', '<leader>t', function()
    edit_directory('.')
end)

map('n', '<leader>T', function()
    local directory = vim.fn.expand('%:p:h')
    edit_directory(vim.fn.isdirectory(directory) == 1 and directory or '.')
end)
