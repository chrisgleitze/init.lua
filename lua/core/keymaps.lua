-- write buffer
vim.keymap.set("n", "<leader>W", function()
    vim.cmd("w")
    print("file written")
end, { desc = "Write file" })

-- source file
vim.keymap.set("n", "<leader>S", function()
    vim.cmd("source %")
    print("sourced file")
end, { desc = "Execute the current file" })

-- quit nvim
vim.keymap.set("n", "<leader>Q", function()
    vim.cmd("wqa!")
end)

-- delete buffer
vim.keymap.set("n", "<leader>db", "<cmd>bdelete<CR>")

--jump up and down a page and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center next and previous search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- moves highlighted lines up (K) or down (J)
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

-- make Y behave like C and D - copy text until end of line
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>")

-- show diagnostic for line under cursor
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end)

-- disable and enable diagnostics in current buffer
local function hide_diagnostics()
    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = false,
    })
end
local function show_diagnostics()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
    })
end
vim.keymap.set("n", "<leader>dh", hide_diagnostics)
vim.keymap.set("n", "<leader>ds", show_diagnostics)
