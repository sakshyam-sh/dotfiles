return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                astro = { "prettier" },
                rust = { "rustfmt" },
                toml = { "taplo" },
            },

            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 2000,
            },
            format_after_save = {
                async = true,
                lsp_fallback = true,
            },
        })
    end,
}
