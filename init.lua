--[[ Bootstrap lazy.nvim --]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

--[[ General settings --]]

local opt = vim.opt
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
opt.guicursor = ""
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.undofile = true
opt.updatetime = 50
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.termguicolors = true
opt.colorcolumn = "80"
opt.completeopt = "menuone,noselect"
opt.clipboard = "unnamedplus"

--[[ Key mappings --]]

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>vs', '<cmd>:vsplit<CR>zz')
vim.keymap.set('n', '<leader>hs', '<cmd>:split<CR>zz')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]])
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>')
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set('n', '<leader>gp', '<cmd>:Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>gt', '<cmd>:Gitsigns toggle_current_line_blame<CR>')

--[[ Auto commands --]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

--[[ Lazy.nvim setup --]]
require("lazy").setup("plugins", {
    spec = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim",            dependencies = "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v3.x",
            dependencies = {
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },

                { "neovim/nvim-lspconfig" },
                { "hrsh7th/nvim-cmp" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "L3MON4D3/LuaSnip" },
            }
        },
        { "nvim-treesitter/nvim-treesitter" },
        { "nvim-treesitter/playground" },
        { "windwp/nvim-autopairs" },
        { "numToStr/Comment.nvim" },
        { "kylechui/nvim-surround" },
        { "windwp/nvim-ts-autotag" },
        { "lewis6991/gitsigns.nvim" },
        { "akinsho/toggleterm.nvim" },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
        },
        { "catppuccin/nvim",                     name = "catppuccin",                             priority = 1000 },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl",                                    opts = {} },
        { "nanotee/zoxide.vim" },
        { "folke/trouble.nvim",                  dependencies = "nvim-tree/nvim-web-devicons", },
        { "tpope/vim-fugitive" },
        { "rose-pine/neovim",                    name = "rose-pine", },
        { 'projekt0n/github-nvim-theme' },
        { "mbbill/undotree" },
        { "folke/which-key.nvim" },
        { "github/copilot.vim" },
        { 'nvim-lualine/lualine.nvim',           dependencies = { 'nvim-tree/nvim-web-devicons' } },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "main",
            dependencies = {
                { "zbirenbaum/copilot.lua" },
                { "nvim-lua/plenary.nvim" },
            },
            opts = {
                debug = true, -- Enable debugging
            },
        },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})
