-- Editor enhancement plugins
return {
    { "numToStr/Comment.nvim" },
    { "windwp/nvim-autopairs" },
    { "mbbill/undotree" },
    { "nanotee/zoxide.vim" },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" }
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 30
                    elseif term.direction == "vertical" then
                        return 0.3
                    end
                end,
                direction = "horizontal",
                autochdir = true,
                shade_terminals = true,
            })

            -- Key mappings for ToggleTerm
            vim.keymap.set({ 'n', 't' }, '<c-t><c-t>', '<cmd>:ToggleTerm<CR>')
            vim.keymap.set('n', '<c-t><c-v>', '<cmd>:ToggleTerm direction="vertical" size=70<CR>')
            vim.keymap.set('n', '<c-t><c-h>', '<cmd>:ToggleTerm direction="horizontal"<CR>')
            vim.keymap.set('n', '<c-t><c-f>', '<cmd>:ToggleTerm direction="float" size=70<CR>')
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                win = {
                    border = "rounded",
                },
            })
            wk.add({
                { "<leader>",  group = "leader" },
                { "<leader>p", group = "project" },
                { "<leader>g", group = "git" },
            })
        end,
    },
}
