-- native on-demand loader for plugin groups (e.g. Diffview, DAP): registers
-- specs eagerly with vim.pack so install/update stays lockfile-driven, but
-- keeps every plugin's runtime files (plugin/, ftdetect/, ...) unsourced
-- until a real trigger (command, keymap, ...) calls M.load

local M = {}
-- name -> { plugins, prepared, loaded }; plugins is filled lazily by the
-- vim.pack `load` callback below, once vim.pack actually resolves the group
local groups = {}

function M.register(name, specs)
    local group = { plugins = {}, prepared = false, loaded = false }
    groups[name] = group

    -- passing a function (instead of true/false) as `load` makes vim.pack
    -- install/update the specs and mark them active, but hands control of
    -- packadd back to us: nothing gets sourced here, we just collect the
    -- resolved plugin objects for later use in prepare()/source()
    vim.pack.add(specs, {
        load = function(plugin)
            group.plugins[#group.plugins + 1] = plugin
        end,
    })
end

-- packadd! (bang) puts each plugin on the runtimepath and requires its Lua
-- modules, but deliberately skips plugin/ and ftdetect/ scripts; needed
-- before configure() can require() the plugin's modules
local function prepare(group)
    if group.prepared then
        return
    end
    for _, plugin in ipairs(group.plugins) do
        vim.cmd.packadd({ plugin.spec.name, bang = true })
    end
    group.prepared = true
end

-- plain packadd (no bang) now sources plugin/ and ftdetect/, defining the
-- plugin's real commands; if startup has already finished (vim_did_enter),
-- also manually source after/plugin/ since Neovim's own startup sequence,
-- which normally does this, has already passed
local function source(group)
    for _, plugin in ipairs(group.plugins) do
        vim.cmd.packadd(plugin.spec.name)
        if vim.v.vim_did_enter == 1 then
            for _, path in ipairs(vim.fn.glob(plugin.path .. '/after/plugin/**/*.{vim,lua}', false, true)) do
                vim.cmd.source(path)
            end
        end
    end
end

-- fully activate a registered group: source its plugin scripts, then run
-- the caller's own setup() calls; idempotent, safe to call from multiple
-- triggers (e.g. several keymaps sharing one DAP group)
function M.load(name, configure)
    local group = assert(groups[name], 'Unknown plugin group: ' .. name)
    if group.loaded then
        return
    end

    prepare(group)
    configure()
    source(group)
    group.loaded = true
end

function M.is_loaded(name)
    local group = assert(groups[name], 'Unknown plugin group: ' .. name)
    return group.loaded
end

-- load a group the first time one of its (not-yet-defined) commands is
-- typed; CmdUndefined fires before Neovim reports "not an editor command",
-- so once configure() defines the real command here, Neovim re-dispatches
-- the command line the user just typed against it
function M.on_command(name, commands, configure)
    local id
    id = vim.api.nvim_create_autocmd('CmdUndefined', {
        pattern = commands,
        callback = function()
            local ok, err = pcall(M.load, name, configure)
            if not ok then
                vim.notify(('Failed to load %s:\n%s'):format(name, err), vim.log.levels.ERROR)
                return
            end
            -- one-shot: the group is loaded now, no need to keep matching CmdUndefined
            vim.api.nvim_del_autocmd(id)
        end,
    })
end

-- load a group the first time a buffer of one of these filetypes is opened;
-- fires once per group even if several matching buffers open in a row
function M.on_filetype(name, filetypes, configure)
    local id
    id = vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
            local ok, err = pcall(M.load, name, configure)
            if not ok then
                vim.notify(('Failed to load %s:\n%s'):format(name, err), vim.log.levels.ERROR)
                return
            end
            vim.api.nvim_del_autocmd(id)
        end,
    })
end

return M
