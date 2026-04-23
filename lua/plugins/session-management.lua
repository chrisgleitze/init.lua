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

        -- directories to exclude
        local excluded_dirs = {
            '/tmp',
            vim.fn.expand('~/'),
            vim.fn.expand('/'),
        }

        local function is_excluded()
            local cwd = vim.fn.getcwd()

            for _, dir in ipairs(excluded_dirs) do
                if cwd == dir or cwd:find('^' .. vim.pesc(dir .. '/')) then
                    return true
                end
            end

            return false
        end

        local function update_persistence()
            if is_excluded() then
                persistence.stop()
            else
                persistence.start()
            end
        end

        vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
            callback = update_persistence,
        })

        -- avoid hit-enter prompts from :mksession messages when quitting
        persistence.save = function()
            if is_excluded() then
                return
            end
            vim.cmd('silent! mks! ' .. vim.fn.fnameescape(persistence.current()))
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
