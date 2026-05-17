-- session management
return {
    'folke/persistence.nvim',
    event = 'VimEnter',
    opts = {
        need = 1, -- save once at least one real file buffer is open
        branch = true, -- keep separate sessions per git branch
    },
    config = function(_, opts)
        local persistence = require('persistence')

        persistence.setup(opts)

        local function normalize_dir(path)
            -- compare canonical directory strings so "~" and trailing slashes do not matter.
            return vim.fn.fnamemodify(vim.fn.expand(path), ':p'):gsub('([^/])/$', '%1')
        end

        local home = normalize_dir('~')
        local tmp = normalize_dir('/tmp')

        local function is_excluded(path)
            local cwd = normalize_dir(path or vim.fn.getcwd())
            -- exclude home/root exactly; exclude /tmp recursively.
            return cwd == home or cwd == '/' or cwd == tmp or cwd:sub(1, #tmp + 1) == tmp .. '/'
        end

        local function sync_persistence()
            if is_excluded() then
                persistence.stop()
            else
                persistence.start()
            end
        end

        local original_load = persistence.load
        persistence.load = function(load_opts)
            -- Do not load the current directory's session while persistence is disabled there.
            if not (load_opts and load_opts.last) and is_excluded() then
                return
            end

            local result = original_load(load_opts)
            -- A session file can change cwd; make sure saving follows the restored state.
            sync_persistence()
            return result
        end

        vim.api.nvim_create_autocmd('DirChanged', {
            group = vim.api.nvim_create_augroup('cg/persistence', { clear = true }),
            callback = sync_persistence,
        })
        -- setup() starts persistence, so apply the exclusion immediately.
        sync_persistence()

        -- avoid hit-enter prompts from :mksession messages when quitting
        persistence.save = function()
            if is_excluded() then
                return
            end

            local ok, err = pcall(
                vim.fn.execute,
                'mksession! ' .. vim.fn.fnameescape(persistence.current()),
                'silent'
            )
            if not ok then
                vim.api.nvim_err_writeln('Failed to save session: ' .. err)
            end
        end

        local map = vim.keymap.set
        -- load the last session manually
        map('n', '<leader>Qs', function()
            require('persistence').load({ last = true })
        end)

        -- select a session to load
        map('n', '<leader>QS', function()
            require('persistence').select()
        end)

        -- load the last session for the current directory
        map('n', '<leader>Ql', function()
            require('persistence').load()
        end)

        -- stop Persistence => session won't be saved on exit
        map('n', '<leader>Qd', function()
            require('persistence').stop()
        end)
    end,
}
