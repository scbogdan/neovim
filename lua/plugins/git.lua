-- Git-related plugins configuration
return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()

            -- Keymaps
            vim.keymap.set('n', '<leader>gp', '<cmd>:Gitsigns preview_hunk<CR>')
            vim.keymap.set('n', '<leader>gt', '<cmd>:Gitsigns toggle_current_line_blame<CR>')
            vim.keymap.set("n", "<leader>gs", "<cmd>:Gitsigns stage_hunk<CR>")
        end,
    },
    { "tpope/vim-fugitive" },
}
