if vim.fn.exists('##CmdAtom') == 1 then
    local last_atom ---@type vim.event.cmdatom.data?
    local last_edit ---@type vim.event.cmdatom.data?
    local maxseq = {} ---@type table<integer, integer>

    local function remember(args)
        local atom = args.data
        local lhs = atom.lhs or ''
        local is_redo_or_undo = atom.changed and (atom.undoseq or 0) <= (maxseq[args.buf] or 0)
        maxseq[args.buf] = vim.fn.undotree(args.buf).seq_last

        local leader_comma = (vim.g.mapleader or '\\') .. ','
        local ignore_lhs = lhs == ',' or lhs == leader_comma or lhs == '<Space>,' or lhs:match('^[hjkl]$')

        if atom.keys == '' then
            return
        elseif atom.changed and not is_redo_or_undo and lhs ~= '.' then
            last_edit = atom
        elseif not atom.changed and not is_redo_or_undo and not ignore_lhs then
            last_atom = atom
        end
    end

    local function replay(atom, fallback)
        if not atom then
            if fallback then
                vim.api.nvim_feedkeys(fallback, 'n', false)
            else
                vim.notify('No CmdAtom action remembered', vim.log.levels.WARN)
            end
            return
        end

        local keys = atom.keys ~= '' and atom.keys or atom.lhs
        if not keys or keys == '' then
            vim.notify('CmdAtom action is not replayable', vim.log.levels.WARN)
            return
        end

        vim.schedule(function()
            vim.api.nvim_feedkeys(keys, atom.keys ~= '' and 'n' or 'm', false)
        end)
    end

    local group = vim.api.nvim_create_augroup('cg/cmdatom_repeat', { clear = true })
    vim.api.nvim_create_autocmd('CmdAtom', {
        desc = 'remember the most recent user action',
        group = group,
        callback = remember,
    })

    vim.keymap.set('n', '<leader>,', function()
        replay(last_atom)
    end, { desc = 'repeat last CmdAtom action' })

    vim.keymap.set('n', '.', function()
        replay(last_edit, '.')
    end, { desc = 'repeat last CmdAtom edit' })
end
