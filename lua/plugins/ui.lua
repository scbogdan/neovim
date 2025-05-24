return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "Love",
                "Gold",
                "Pine",
                "Iris",
                "Foam",
                "Text",
                "Rose",
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "Foam", { fg = "#9ccfd8" })
                vim.api.nvim_set_hl(0, "Love", { fg = "#eb6f92" })
                vim.api.nvim_set_hl(0, "Gold", { fg = "#f6c177" })
                vim.api.nvim_set_hl(0, "Text", { fg = "#e0def4" })
                vim.api.nvim_set_hl(0, "Iris", { fg = "#c4a7e7" })
                vim.api.nvim_set_hl(0, "Rose", { fg = "#ebbcba" })
                vim.api.nvim_set_hl(0, "Pine", { fg = "#31748f" })
            end)

            require("ibl").setup {
                -- indent = { highlight = highlight },
                scope = { highlight = highlight }
            }

            -- vim.g.rainbow_delimiters = { highlight = highlight }
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- Optional, for file icons
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'horizon',
                    section_separators = '',
                    component_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end,
    },
}
