vim.g.mapleader = " "

-- hidden buffers are not displayed but loaded in memory
vim.opt.hidden = true

-- set absolute number for current line, relative numbers for all other lines
vim.opt.nu = true
vim.opt.rnu = true

-- creation of swapfiles and backup files
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

-- highlight search, incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 10

vim.opt.guicursor = { "n-v-ve-o-r-c-cr-sm:block-blinkon175", "i-ci:ver25-blinkon175" }

-- cursorline not highlighted
vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[highlight CursorLine guibg=NONE cterm=underline]],
})

vim.diagnostic.enable(false)

-- disable animations of snacks.nvim
vim.g.snacks_animate = false
