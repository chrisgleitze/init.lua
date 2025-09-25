return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        vim.env.ESLINT_D_PPID = vim.fn.getpid()
        require("lint").linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
        }

        -- create autocommand group
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        -- execute linter on certain events
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        -- keymap for linting
        vim.keymap.set("n", "<leader>li", function()
            lint.try_lint()
            print("linting done")
        end)
    end,
}
