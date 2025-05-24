return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "vim", "vimdoc", "query",
                    "javascript", "typescript", "tsx",
                    "html", "css", "json", "yaml",
                    "python", "rust", "go", "c", "cpp",
                    "bash", "markdown", "markdown_inline"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    { "nvim-treesitter/playground" },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true
                    },
                    ["javascript"] = {
                        enable_close = true
                    },
                    ["typescript"] = {
                        enable_close = true
                    },
                    ["javascriptreact"] = {
                        enable_close = true
                    },
                    ["typescriptreact"] = {
                        enable_close = true
                    },
                    ["vue"] = {
                        enable_close = true
                    },
                    ["xml"] = {
                        enable_close = true
                    },
                    ["markdown"] = {
                        enable_close = false
                    },
                }
            })
        end,
    },
}
