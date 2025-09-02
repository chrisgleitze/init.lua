return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            rust = { "rustfmt" },
            yaml = { "prettier" },
        },
        format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
        },
    },
}
