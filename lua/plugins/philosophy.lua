local plugins = {
    { path = vim.fn.expand('~/projects/kant.nvim'), module = 'kant' },
    { path = vim.fn.expand('~/projects/hegel.nvim'), module = 'hegel' },
}

for _, plugin in ipairs(plugins) do
    vim.opt.runtimepath:append(plugin.path)

    -- Make commands available before the normal startup plugin scan.
    for _, file in ipairs(vim.fn.glob(plugin.path .. '/plugin/*.lua', false, true)) do
        dofile(file)
    end

    require(plugin.module).setup()
end
