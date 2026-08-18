vim.opt_local.autoindent = false
vim.opt_local.spell = true
vim.opt_local.spelllang = { 'de_de', 'en_us' }
vim.opt_local.spellcapcheck = ''
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- accept first spell suggestion for word under the cursor
vim.keymap.set('n', 'zs', '1z=', { buf = 0 })
