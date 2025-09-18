-- Formatting
return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        formatters_by_ft = {
            c = { "clangd" },
            cpp = { "clangd" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettier" },
            less = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            rust = { "rust_analyzer" },
            scss = { "prettier" },
            sh = { "shfmt" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            yaml = { "prettier" },
        },
        formatters = {
            ["clangd"] = {
                prepend_args = { "-style=file", "-fallback-style=LLVM" },
            },
        },
        format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
        },
        vim.keymap.set("n", "<leader>F", function()
            require("conform").format({ bufnr = 0 })
            print("buffer formatted")
        end),
    },
}
