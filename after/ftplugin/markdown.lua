vim.opt_local.autoindent = false
vim.opt_local.spelllang = { 'de_de', 'en_us' }
vim.opt_local.spellcapcheck = ''
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- accept first spell suggestion for word under the cursor
vim.keymap.set('n', 'zs', '1z=', { buf = 0 })

-- export the current Markdown buffer with pandoc
-- usage: :PandocHtml, :PandocDocx, or :PandocPDF
local function pandoc(ext)
    -- empty name means an unsaved scratch buffer
    local input = vim.api.nvim_buf_get_name(0)
    if input == '' then
        return
    end

    if vim.fn.executable('pandoc') == 0 then
        vim.notify('pandoc not found', vim.log.levels.ERROR)
        return
    end

    -- save first so pandoc exports current buffer contents
    vim.cmd.write()

    -- keep the same path and basename, only replace the extension
    local output = vim.fn.fnamemodify(input, ':r') .. ext
    local args = { 'pandoc', '-s', input, '-o', output }

    -- run pandoc asynchronously so Neovim stays usable
    vim.system(args, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify('Wrote ' .. output)
            else
                vim.notify(obj.stderr, vim.log.levels.ERROR)
            end
        end)
    end)
end

vim.api.nvim_buf_create_user_command(0, 'PandocHtml', function()
    pandoc('.html')
end, {})

vim.api.nvim_buf_create_user_command(0, 'PandocDocx', function()
    pandoc('.docx')
end, {})

vim.api.nvim_buf_create_user_command(0, 'PandocPDF', function()
    pandoc('.pdf')
end, {})
