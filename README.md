# Neovim Configuration

A comprehensive Neovim configuration focused on DevOps and development workflows.
Includes LSP support for multiple languages (Python, Go, Rust, JavaScript/TypeScript,
Terraform, Docker, etc.), powerful fuzzy finding with Telescope,
Git integration with visual diffs and blame, GitHub Copilot support,
syntax highlighting, code formatting, and a clean UI with statusline and themes.

## Setup

### Prerequisites

- Neovim 0.9+
- Git
- Node.js

### Install

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone and start
git clone https://github.com/scbogdan/neovim.git ~/.config/nvim
nvim
```

First launch will auto-install everything.

### Markdown Preview Setup

If you plan to use markdown preview, run this after installation:

```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim && npm install
```

## Learning Keybindings

**Leader key**: `<Space>`

Press `<Space>` and wait - **Which-Key** will show you all available commands organized by category. You can also explore other key combinations like:

- `g` - Go to commands (definitions, references, etc.)
- `]` and `[` - Navigation (next/previous diagnostics, hunks, etc.)
- `<C-t>` - Terminal commands
- `<` and `>` - Indentation in visual mode
- `z` - Folding and view commands

This is the best way to discover what's available and learn the keybindings.

## Plugin Management

### Add Plugin

Edit files in `lua/plugins/`, add:

```lua
{
    "author/plugin-name",
    config = function()
        require("plugin-name").setup()
    end,
}
```

### Remove Plugin

Delete the plugin block from its file and restart Neovim.

### Commands

- `:Lazy` - Manage plugins
- `:Lazy sync` - Update all
- `:Mason` - Manage LSP servers

## Adding Keybindings

In `init.lua` or plugin config files:

```lua
vim.keymap.set("n", "<leader>my", "<cmd>MyCommand<CR>")
```

## File Structure

```
lua/plugins/
├── lsp.lua        # Language servers
├── telescope.lua  # Fuzzy finder
├── git.lua        # Git integration
├── ui.lua         # Themes & statusline
├── editor.lua     # Editor enhancements
├── format.lua     # Code formatting
└── ...
```

## Troubleshooting

- `:checkhealth` - Check setup
- `:LspInfo` - Check language servers
- `:Lazy profile` - Check performance
