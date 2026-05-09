-- color highlighter
return {
    'catgoose/nvim-colorizer.lua',
    ft = { 'css', 'scss', 'html', 'javascript', 'typescript', 'json', 'jsonc', 'lua', 'yaml' },
    options = {
        user_default_options = {
            tailwind = true,
            css = true,
            names = false,
            mode = 'background',
        },
        filetypes = {
            'css',
            'scss',
            'html',
            'javascript',
            'typescript',
            'json',
            'jsonc',
            'lua',
            'yaml',
        },
    },
}
