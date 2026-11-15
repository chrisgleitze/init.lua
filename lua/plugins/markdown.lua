local loader = require('plugin_loader')

-- both plugins read these vim.g settings from their own plugin/ script at
-- source time, so they must be set before loader.load() sources it
local function configure()
    -- its startup script passes this table to setup()
    vim.g.render_markdown_config = {
        -- don't render large Markdown files
        max_file_size = 1.5,
        link = {
            enabled = false, -- inline link icon rendering
            footnote = {
                enabled = true,
                superscript = true,
            },
        },
    }

    vim.g.mkdp_filetypes = { 'markdown' }

    -- WSL: /etc/wsl.conf sets appendWindowsPath=false, so the bundled
    -- opener dies with "spawn cmd.exe ENOENT". There is no Linux browser
    -- here either, so hand the URL to the Windows default browser through
    -- the absolute interop path instead. cwd must be a path cmd.exe can
    -- resolve or it warns about UNC paths.
    if vim.fn.executable('/mnt/c/Windows/System32/cmd.exe') == 1 then
        vim.cmd([[
            function! MkdpBrowser(url) abort
              call jobstart(['/mnt/c/Windows/System32/cmd.exe', '/c', 'start', '""', a:url],
                    \ {'cwd': '/mnt/c', 'detach': v:true})
            endfunction
        ]])
        vim.g.mkdp_browserfunc = 'MkdpBrowser'
    end
end

-- load render-markdown + markdown-preview on the first markdown buffer
loader.on_filetype('markdown', 'markdown', configure)

local group = vim.api.nvim_create_augroup('cg/markdown-maps', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'markdown',
    callback = function(args)
        vim.keymap.set('n', '<leader>Md', function()
            require('render-markdown').buf_toggle()
        end, { buffer = args.buf })
        vim.keymap.set('n', '<leader>Mp', '<cmd>MarkdownPreviewToggle<cr>', { buffer = args.buf })
        -- jump to Markdown heading
        vim.keymap.set('n', '<leader>Mj', function()
            local title = vim.api.nvim_get_current_line():match('%[([^%]]+)%]%(%#[^%)]+%)')
            if title then
                -- shortcut: link text must match the heading, use anchor resolution if labels differ
                for i, line in ipairs(vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)) do
                    if line:match('^#+%s+(.+)%s*$') == title then
                        vim.cmd('normal! ' .. i .. 'G0')
                        return
                    end
                end
            end
            vim.notify('No matching Markdown heading found', vim.log.levels.WARN)
        end, { buffer = args.buf })
    end,
})
