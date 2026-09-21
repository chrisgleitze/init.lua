-- run a blocking shell command, error with its output on failure
local function run(cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd, text = true }):wait()
    if result.code ~= 0 then
        local message = result.stderr or result.stdout or ''
        error(message ~= '' and message or table.concat(cmd, ' ') .. ' failed')
    end
end

-- run build steps for plugins with native code/assets after install/update
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('cg/plugin_builds', { clear = true }),
    callback = function(event)
        local name = event.data.spec.name
        local kind = event.data.kind
        -- only react to fresh installs/updates, not removals
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        local ok, err = pcall(function()
            if name == 'LuaSnip' then
                -- build the optional jsregexp C dependency for variable transforms
                run({ 'make', 'install_jsregexp' }, event.data.path)
            elseif name == 'fff.nvim' then
                -- fetch/build its Rust binary, falling back to a local cargo build
                if not event.data.active then
                    vim.cmd.packadd(name)
                end
                local download = require('fff.download')
                download.download_or_build_binary()
                if not vim.uv.fs_stat(download.get_binary_path()) then
                    run({ 'cargo', 'build', '--release', '-p', 'fff-nvim', '--lib' }, event.data.path)
                end
            elseif name == 'markdown-preview.nvim' then
                -- install its bundled Node app, discarding any resulting git diff
                run({ 'sh', '-c', 'cd app && npm install && git restore .' }, event.data.path)
            elseif name == 'nvim-treesitter' then
                -- pull/rebuild all treesitter parsers
                if not event.data.active then
                    vim.cmd.packadd(name)
                end
                vim.cmd.TSUpdate()
            end
        end)
        if not ok then
            vim.notify(('Failed to build %s:\n%s'):format(name, err), vim.log.levels.ERROR)
        end
    end,
})

-- plugin_loader defers these groups until their trigger fires (see each module)
local loader = require('plugin_loader')
loader.register('diffview', { 'https://github.com/dlyongemallo/diffview.nvim' })
loader.register('harpoon', { { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' } })
loader.register('markdown', {
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/iamcco/markdown-preview.nvim',
})
loader.register('neo-tree', { { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' } })

-- everything else: install/clone only (load = false), each gets set up by
-- its own module below or by the deferred block at the end
vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/rafamadriz/friendly-snippets',
    { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('2.x') },
    'https://github.com/nvim-treesitter/nvim-treesitter',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
    'https://github.com/ibhagwan/fzf-lua',
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/dmtrKovalenko/fff.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/junegunn/gv.vim',
    'https://github.com/echasnovski/mini.surround',
    { src = 'https://github.com/zk-org/zk-nvim', name = 'zk' },
}, { load = false })

-- needs to load first
require('plugins.colorscheme')

local mason = require('plugins.mason')
-- Modules that need to load later (after VimEnter),
-- excluded from the eager auto-require loop below
local later = {
    ['fff.lua'] = true,
    ['fzf-lua.lua'] = true,
    ['mason.lua'] = true,
}
-- auto-discover and require every remaining lua/plugins/*.lua file
local configs = {}
for name, type in vim.fs.dir(vim.fn.stdpath('config') .. '/lua/plugins') do
    if
        type == 'file'
        and name:match('%.lua$')
        and name ~= 'init.lua'
        and name ~= 'colorscheme.lua'
        and not later[name]
    then
        configs[#configs + 1] = name:sub(1, -5)
    end
end

-- sort for a deterministic load order (dir iteration order is unspecified)
table.sort(configs)
for _, config in ipairs(configs) do
    require('plugins.' .. config)
end

-- defer the heavier/startup-sensitive setups until after VimEnter so they
-- don't block editor startup: fzf-lua, fff (native binary), and mason
vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('cg/deferred_plugin_setup', { clear = true }),
    once = true,
    callback = function()
        vim.schedule(function()
            local ok, err = pcall(function()
                require('plugins.fzf-lua')
                require('plugins.fff')
                mason.setup()
            end)
            if not ok then
                vim.notify(('Deferred plugin setup failed:\n%s'):format(err), vim.log.levels.ERROR)
            end
        end)
    end,
})
