-- npm install -g @tailwindcss/language-server

-- Prefer explicit Tailwind/PostCSS project markers over a broad .git fallback,
-- otherwise the Tailwind server starts in almost every web-adjacent repo.
local explicit_root_markers = {
    -- Generic
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
    -- Django
    'theme/static_src/tailwind.config.js',
    'theme/static_src/tailwind.config.cjs',
    'theme/static_src/tailwind.config.mjs',
    'theme/static_src/tailwind.config.ts',
    'theme/static_src/postcss.config.js',
}

local function has_tailwind_dependency(package_json)
    local lines = vim.fn.readfile(package_json)
    if not lines then
        return false
    end

    local ok, package = pcall(vim.json.decode, table.concat(lines, '\n'))
    if not ok or type(package) ~= 'table' then
        return false
    end

    -- Tailwind v4 projects may not have a config file, so package.json
    -- dependencies are the second, narrower activation signal.
    for _, section in ipairs({ 'dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies' }) do
        local dependencies = package[section]
        if type(dependencies) == 'table' then
            if dependencies.tailwindcss then
                return true
            end

            for name in pairs(dependencies) do
                if name:match('^@tailwindcss/') then
                    return true
                end
            end
        end
    end

    return false
end

---@type vim.lsp.Config
return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = {
        'css',
        'sass',
        'scss',
        'less',
        'html',
        'htmlangular',
        'javascript',
        'javascriptreact',
        'markdown',
        'mdx',
        'php',
        'svelte',
        'typescript',
        'typescriptreact',
        'vue',
    },
    root_dir = function(bufnr, on_dir)
        -- Calling on_dir() is what opts the buffer into starting this LSP.
        -- If neither condition matches, the server is intentionally skipped.
        local explicit_root = vim.fs.root(bufnr, explicit_root_markers)
        if explicit_root then
            on_dir(explicit_root)
            return
        end

        local package_root = vim.fs.root(bufnr, 'package.json')
        if package_root and has_tailwind_dependency(package_root .. '/package.json') then
            on_dir(package_root)
        end
    end,
}
