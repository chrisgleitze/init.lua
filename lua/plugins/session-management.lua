-- session management plugin
return {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
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
    end,
}
