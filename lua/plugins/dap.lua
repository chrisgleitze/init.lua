-- Debugger
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "igorlfs/nvim-dap-view",
            ---@module 'dap-view'
            ---@type dapview.Config
            opts = {},
        },
        -- Lua adapter
        {
            "jbyuki/one-small-step-for-vimkind",
            keys = {
                {
                    "<leader>dl",
                    function()
                        require("osv").launch({ port = 8086 })
                    end,
                    desc = "Launch Lua adapter",
                },
            },
        },
        -- adds virtual text in debugging session
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = { virt_text_pos = "eol" },
        },
    },
    config = function()
        local dap = require("dap")
        dap.set_log_level("DEBUG")
        local map = vim.keymap.set

        map("n", "<leader>db", dap.toggle_breakpoint)
        map("n", "<leader>df", "<cmd>FzfLua dap_breakpoints<cr>")
        map("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        map("n", "<leader>dc", dap.continue)
        map("n", "<leader>di", dap.step_into)
        map("n", "<leader>do", dap.step_over)
        map("n", "<leader>da", dap.step_back)
        map("n", "<leader>du", dap.step_out)

        -- opens UI when starting a new debug session
        local dv = require("dap-view")
        dap.listeners.before.attach["dap-view-config"] = function()
            dv.open()
        end
        dap.listeners.before.launch["dap-view-config"] = function()
            dv.open()
        end
        dap.listeners.before.event_terminated["dap-view-config"] = function()
            dv.close()
        end
        dap.listeners.before.event_exited["dap-view-config"] = function()
            dv.close()
        end

        -- Lua config, plugin: one-small-step-for-vimkind
        dap.configurations["lua"] = {
            {
                type = "nlua",
                request = "attach",
                name = "Attach to running Neovim instance",
            },
        }
        dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end

        -- C, C++, Rust config
        -- LLDB debugger, part of the LLVM project
        dap.adapters.codelldb = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }
    end,
}
