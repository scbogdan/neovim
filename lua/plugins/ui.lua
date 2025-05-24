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
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            -- Custom components
            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end

            -- Custom mode names
            local mode_map = {
                ['n'] = 'NORMAL',
                ['no'] = 'O-PENDING',
                ['nov'] = 'O-PENDING',
                ['noV'] = 'O-PENDING',
                ['no\22'] = 'O-PENDING',
                ['niI'] = 'NORMAL',
                ['niR'] = 'NORMAL',
                ['niV'] = 'NORMAL',
                ['nt'] = 'NORMAL',
                ['ntT'] = 'NORMAL',
                ['v'] = 'VISUAL',
                ['vs'] = 'VISUAL',
                ['V'] = 'V-LINE',
                ['Vs'] = 'V-LINE',
                ['\22'] = 'V-BLOCK',
                ['\22s'] = 'V-BLOCK',
                ['s'] = 'SELECT',
                ['S'] = 'S-LINE',
                ['\19'] = 'S-BLOCK',
                ['i'] = 'INSERT',
                ['ic'] = 'INSERT',
                ['ix'] = 'INSERT',
                ['R'] = 'REPLACE',
                ['Rc'] = 'REPLACE',
                ['Rx'] = 'REPLACE',
                ['Rv'] = 'V-REPLACE',
                ['Rvc'] = 'V-REPLACE',
                ['Rvx'] = 'V-REPLACE',
                ['c'] = 'COMMAND',
                ['cv'] = 'EX',
                ['ce'] = 'EX',
                ['r'] = 'REPLACE',
                ['rm'] = 'MORE',
                ['r?'] = 'CONFIRM',
                ['!'] = 'SHELL',
                ['t'] = 'TERMINAL',
            }

            local function custom_mode()
                return mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
            end

            -- LSP clients function
            local function lsp_clients()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                    return ""
                end

                local client_names = {}
                for _, client in ipairs(clients) do
                    table.insert(client_names, client.name)
                end
                return " LSP: " .. table.concat(client_names, ", ")
            end

            -- File size function
            local function file_size()
                local size = vim.fn.getfsize(vim.fn.expand('%:p'))
                if size <= 0 then return '' end

                local suffixes = { 'B', 'KB', 'MB', 'GB' }
                local i = 1
                while size > 1024 and i < #suffixes do
                    size = size / 1024
                    i = i + 1
                end
                return string.format('%.1f%s', size, suffixes[i])
            end

            -- Search count
            local function search_count()
                if vim.v.hlsearch == 0 then return '' end
                local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 100 })
                if not ok or result.incomplete == 1 or result.total == 0 then return '' end
                if result.total == 1 then return '[1/1]' end
                return string.format('[%d/%d]', result.current, result.total)
            end

            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { 'alpha', 'dashboard', 'NvimTree', 'Outline', 'neo-tree' },
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true, -- Single statusline for all windows
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {
                        {
                            custom_mode,
                            color = { gui = 'bold' },
                            separator = { right = '' },
                        }
                    },
                    lualine_b = {
                        {
                            'branch',
                            icon = '',
                            color = { gui = 'bold' },
                        },
                        {
                            'diff',
                            source = diff_source,
                            symbols = { added = ' ', modified = ' ', removed = ' ' },
                            diff_color = {
                                added = { fg = '#98be65' },
                                modified = { fg = '#ECBE7B' },
                                removed = { fg = '#ec5f67' },
                            },
                        },
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            newfile_status = true,
                            path = 1, -- Show relative path
                            symbols = {
                                modified = ' ●',
                                readonly = ' ',
                                unnamed = '[No Name]',
                                newfile = ' New',
                            }
                        },
                        {
                            search_count,
                            color = { fg = '#ff9e64' },
                        }
                    },
                    lualine_x = {
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic', 'nvim_lsp' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
                            diagnostics_color = {
                                error = { fg = '#ec5f67' },
                                warn = { fg = '#ECBE7B' },
                                info = { fg = '#008080' },
                                hint = { fg = '#10B981' },
                            },
                        },
                        {
                            lsp_clients,
                            icon = '',
                            color = { fg = '#7aa2f7' },
                        },
                        {
                            file_size,
                            color = { fg = '#aab2bf' },
                        },
                    },
                    lualine_y = {
                        {
                            'encoding',
                            fmt = string.upper,
                            cond = function()
                                return vim.bo.fileencoding ~= 'utf-8'
                            end
                        },
                        {
                            'fileformat',
                            symbols = {
                                unix = ' LF',
                                dos = ' CRLF',
                                mac = ' CR',
                            },
                        },
                        {
                            'filetype',
                            colored = true,
                            icon_only = false,
                            icon = { align = 'right' },
                        }
                    },
                    lualine_z = {
                        {
                            'progress',
                            separator = { left = '' },
                            color = { gui = 'bold' },
                        },
                        {
                            'location',
                            color = { gui = 'bold' },
                        },
                        {
                            function()
                                return ' ' .. vim.fn.line('$')
                            end,
                            color = { fg = '#aab2bf' },
                        }
                    }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 1,
                        }
                    },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = { 'nvim-tree', 'toggleterm', 'quickfix', 'neo-tree' }
            }
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.10,
            },
            no_italic = true,
            no_bold = false,
            no_underline = false,
            styles = {
                comments = {},
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
            -- Add this after your colorscheme setup
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NormalFloat guibg=NONE ctermbg=NONE
            highlight SignColumn guibg=NONE ctermbg=NONE
            highlight EndOfBuffer guibg=NONE ctermbg=NONE
        ]])
                end,
            })
        end,
    }
}
