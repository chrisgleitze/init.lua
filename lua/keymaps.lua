local map = vim.keymap.set

-- open Lazy.nvim plugin manager
map("n", "<leader>L", "<cmd>Lazy<cr>")

-- write buffer
map("n", "<leader>W", function()
    vim.cmd("w")
    print("buffer saved")
end)

-- source buffer
map("n", "<leader>S", function()
    vim.cmd("source %")
    print("buffer sourced")
end)

-- quit nvim
map("n", "<leader>Q", function()
    vim.cmd("wqa!")
end)

-- make Y behave like C and D - copy text until end of line
map("n", "Y", "yg_")

-- delete buffer
map("n", "<leader>db", "<cmd>bdelete<CR>")

--jump up and down a page and center cursor
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- center next and previous search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- moves highlighted lines up (K) or down (J) in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- move lines up or down in normal, insert, and visual modes
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- helps you change all occurrences of the word the cursor is on
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
