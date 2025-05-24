-- This code configures Neovim's built-in LSP client with the lsp-zero plugin,
-- which simplifies LSP setup and configuration.
return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        local cmp = require("cmp")
        local lspconfig = require("lspconfig")

        -- Mason setup
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- Mason-lspconfig setup with automatic installation
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "dockerls",
                "docker_compose_language_service",
                "emmet_ls",
                "gopls",
                "html",
                "jsonls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "terraformls",
                "ts_ls",
                "yamlls",
            },
            automatic_installation = true,
        })

        -- CMP setup
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- LSP on_attach function with keymaps
        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            -- Navigation
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- Diagnostics (fixed the function calls)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            -- Actions
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

            -- Signature help (fixed typo)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

            -- Format command
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format({ async = true })
            end, { desc = 'Format current buffer with LSP' })
        end)

        -- DevOps Language Server Configurations
        local servers = {
            -- Shell scripting
            bashls = {},

            -- Docker
            dockerls = {},
            docker_compose_language_service = {},

            -- Web technologies
            html = {
                filetypes = { "html", "templ" }
            },
            emmet_ls = {
                filetypes = { "html", "css", "scss", "javascript", "typescript", "templ" }
            },

            -- Go
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },

            -- JSON/YAML
            jsonls = {},
            yamlls = {
                settings = {
                    yaml = {
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose*.yml",
                            ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
                            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                            "/compose*.yml",
                        }
                    }
                }
            },

            -- Infrastructure as Code
            terraformls = {
                settings = {
                    terraform = {
                        completion = {
                            enable = true
                        }
                    }
                }
            },

            -- Python
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        }
                    }
                }
            },

            -- Rust
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },

            -- JavaScript/TypeScript
            ts_ls = {},

            -- Vim
            vimls = {},

            -- Lua with Neovim configuration
            lua_ls = {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT"
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                    }
                                },
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        })
                        client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end
            },
        }

        -- Setup all servers
        for server, config in pairs(servers) do
            lspconfig[server].setup(config)
        end

        -- Special filetypes
        vim.filetype.add({
            extension = {
                templ = "templ",
                tf = "terraform",
                tfvars = "terraform"
            }
        })

        -- Auto-formatting for specific file types
        local format_group = vim.api.nvim_create_augroup("LspFormat", { clear = true })

        -- Terraform auto-format
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.tf", "*.tfvars" },
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
            group = format_group,
        })

        -- Python black formatting (if you have black installed)
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.py",
            callback = function()
                vim.fn.system("black " .. vim.fn.expand("%"))
                vim.cmd("edit") -- Reload the file
            end,
            group = format_group,
        })

        -- Go auto-format and imports
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                vim.lsp.buf.format({ async = false })
                -- Organize imports
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
                        end
                    end
                end
            end,
            group = format_group,
        })

        -- LSP Zero setup
        lsp_zero.setup()

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                severity = { min = vim.diagnostic.severity.WARN },
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Diagnostic signs
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Optional: Set log level (uncomment if you want to debug)
        -- vim.lsp.set_log_level("DEBUG")
    end
}
