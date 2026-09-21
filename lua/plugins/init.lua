local function run(cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd, text = true }):wait()
    if result.code ~= 0 then
        local message = result.stderr or result.stdout or ''
        error(message ~= '' and message or table.concat(cmd, ' ') .. ' failed')
    end
end

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('cg/plugin_builds', { clear = true }),
    callback = function(event)
        local name = event.data.spec.name
        local kind = event.data.kind
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        local ok, err = pcall(function()
            if name == 'LuaSnip' then
                run({ 'make', 'install_jsregexp' }, event.data.path)
            elseif name == 'fff.nvim' then
                if not event.data.active then
                    vim.cmd.packadd(name)
                end
                local download = require('fff.download')
                download.download_or_build_binary()
                if not vim.uv.fs_stat(download.get_binary_path()) then
                    run({ 'cargo', 'build', '--release', '-p', 'fff-nvim', '--lib' }, event.data.path)
                end
            elseif name == 'markdown-preview.nvim' then
                run({ 'sh', '-c', 'cd app && npm install && git restore .' }, event.data.path)
            elseif name == 'nvim-treesitter' then
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
    'https://github.com/dmmulroy/ts-error-translator.nvim',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/dmtrKovalenko/fff.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
    'https://github.com/dlyongemallo/diffview.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/junegunn/gv.vim',
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/igorlfs/nvim-dap-view',
    'https://github.com/jbyuki/one-small-step-for-vimkind',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/iamcco/markdown-preview.nvim',
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
    'https://github.com/nvim-mini/mini.splitjoin',
    'https://github.com/echasnovski/mini.surround',
    { src = 'https://github.com/zk-org/zk-nvim', name = 'zk' },
}, { load = false })

require('plugins.colorscheme')
require('plugins.completion')
require('plugins.autopairs')
require('plugins.treesitter')
require('plugins.gitsigns')
require('plugins.formatting')
require('plugins.mason')
require('plugins.fzf-lua')
require('plugins.fff')
require('plugins.harpoon')
require('plugins.neo-tree')
require('plugins.splitjoin')
require('plugins.surround')
require('plugins.fugitive')
require('plugins.diffview')
require('plugins.octo')
require('plugins.dap')
require('plugins.markdown')
require('plugins.zettelkasten')
require('plugins.philosophy')
require('plugins.schemastore')
