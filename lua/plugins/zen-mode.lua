return {
    "folke/zen-mode.nvim",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0,
                    height = 0.95,
                    width = 0.6,
                    options = {
                        -- signcolumn = "no",
                        cursorline = true,
                    },
                },
            })
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
        end)

        vim.keymap.set("n", "<leader>zZ", function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0,
                    height = 0.9,
                    width = 0.6,
                    options = {
                        signcolumn = "no",
                        cursorline = true,
                    },
                },
            })
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
        end)
    end,
}
