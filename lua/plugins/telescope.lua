-- Telescope configuration for Neovim
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            require("telescope").setup {
                pickers = {
                    -- find_files = {
                    --     hidden = true,
                    -- },
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                        },
                    },
                },
            }

            -- Key mappings for Telescope
            vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "[C]ommand [H]istory" })
            vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "[S]earch [H]istory" })
            vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "[P]roject [H]elp" })
            vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, { desc = "[G]o to [I]mplementations" })
            vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "[G]o to [R]eferences" })
            vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "[P]roject [B]uffers" })
            vim.keymap.set("n", "<leader>pw", builtin.grep_string, { desc = "[P]roject by [W]ord" })
            vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "[P]roject by [G]rep" })
            vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[P]roject [D]iagnostics" })
            vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
            vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "[G]it [F]iles" })
            vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
            vim.keymap.set("n", "<leader>af", function() builtin.find_files({ hidden = true }) end,
                { desc = "[A]ll [F]iles" })
            vim.keymap.set("n", "<leader><space>",
                function()
                    builtin.buffers(themes.get_dropdown {
                        previewer = false,
                        layout_config = {
                            height = 40,
                            width = 120,
                        },
                    })
                end, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(themes.get_dropdown {
                    previewer = false,
                    layout_config = {
                        height = 40,
                        width = 120,
                    },
                })
            end, { desc = "[/] Fuzzily search in current buffer]" })
        end,
    },
}
