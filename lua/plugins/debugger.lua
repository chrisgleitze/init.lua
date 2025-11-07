-- Debugger
return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        dap.set_log_level("DEBUG")
        local map = vim.keymap.set

        map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        map("n", "<leader>df", "<cmd>FzfLua dap_breakpoints<cr>", { desc = "Debug: Toggle Breakpoint" })
        map("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Conditional Breakpoint" })
        map("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
        map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
        map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
        map("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
    end,
}
