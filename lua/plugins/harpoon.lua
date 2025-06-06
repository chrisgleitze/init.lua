return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- Switch to harpooned file 1-4
        vim.keymap.set("n", "<leader>q", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>w", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>e", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>r", function()
            harpoon:list():select(4)
        end)

        -- susbstitute harpoon file 1-4 with new files
        vim.keymap.set("n", "<leader><C-q>", function()
            harpoon:list():replace_at(1)
        end)
        vim.keymap.set("n", "<leader><C-w>", function()
            harpoon:list():replace_at(2)
        end)
        vim.keymap.set("n", "<leader><C-e>", function()
            harpoon:list():replace_at(3)
        end)
        vim.keymap.set("n", "<leader><C-r>", function()
            harpoon:list():replace_at(4)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
