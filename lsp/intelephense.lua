-- PHP Code Intelligence, Formatting etc.
-- npm i intelephense -g
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php', 'blade' },
    root_markers = { 'composer.json', '.git', '*.php' },
}
