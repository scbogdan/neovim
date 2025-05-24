-- Formatting plugins
return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    bash = { "shfmt" },
                    sh = { "shfmt" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })

            -- Create Format command
            vim.api.nvim_create_user_command("Format", function()
                require("conform").format({ lsp_fallback = true })
            end, {})

            -- Keymap
            vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>')
        end,
    },
}
