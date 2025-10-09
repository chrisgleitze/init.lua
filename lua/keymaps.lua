-- open Lazy.nvim plugin manager
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- write buffer
vim.keymap.set("n", "<leader>W", function()
    vim.cmd("w")
    print("buffer saved")
end)

-- source buffer
vim.keymap.set("n", "<leader>S", function()
    vim.cmd("source %")
    print("buffer sourced")
end)

-- quit nvim
vim.keymap.set("n", "<leader>Q", function()
    vim.cmd("wqa!")
end)

-- make Y behave like C and D - copy text until end of line
vim.keymap.set("n", "Y", "yg_")

-- delete buffer
vim.keymap.set("n", "<leader>db", "<cmd>bdelete<CR>")

--jump up and down a page and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center next and previous search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- moves highlighted lines up (K) or down (J) in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move lines up or down in normal, insert, and visual modes
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- helps you change all occurrences of the word the cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
