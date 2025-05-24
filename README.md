# Neovim Configuration

A modern, feature-rich Neovim configuration focused on development productivity with LSP support, Git integration, and intelligent code completion.

## Features

- **LSP Integration**: Full language server support with auto-completion, diagnostics, and code actions
- **Git Integration**: Gitsigns for diff visualization and vim-fugitive for Git commands
- **Telescope**: Fuzzy finder for files, grep, and more
- **Treesitter**: Advanced syntax highlighting and code parsing
- **GitHub Copilot**: AI-powered code suggestions and chat
- **Auto-formatting**: Format-on-save for multiple languages
- **Terminal Integration**: Built-in terminal with toggleterm
- **Theme Support**: Multiple colorschemes including Catppuccin and Rose Pine

## Prerequisites (macOS)

### Neovim

```bash
brew install neovim
```

### Required Tools

```bash
# Node.js (for LSP servers and Copilot)
brew install nvm
nvm install --lts
nvm use --lts

# Ripgrep (for Telescope live grep)
brew install ripgrep

# Git (for version control and vim-fugitive)
brew install git

# Make (for building telescope-fzf-native)
xcode-select --install

# Additional formatters
brew install stylua      # Lua formatting
brew install shfmt       # Shell script formatting
npm install -g prettier  # Web technologies formatting
pip install black       # Python formatting
```

### Optional Tools

```bash
# Zoxide (for smart directory jumping)
brew install zoxide

# GitHub CLI (for Copilot authentication)
brew install gh
```

## Setup Guide

1. **Backup existing configuration** (if you have one):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:

   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Install plugins**:
   Open Neovim and the plugin manager will automatically install all plugins:

   ```bash
   nvim
   ```

   Wait for Lazy.nvim to finish installing all plugins.

4. **Install LSP servers**:
   Open Neovim and run:

   ```
   :Mason
   ```

   The configured LSP servers will be automatically installed thanks to the `ensure_installed` configuration.

5. **Setup GitHub Copilot** (optional):
   ```
   :Copilot setup
   ```
   Follow the authentication prompts.

## Language Server Protocol (LSP) Setup

This configuration comes with LSP servers pre-configured for the following languages:

### Included LSP Servers

- **Bash**: `bashls`
- **Docker**: `dockerls`, `docker_compose_language_service`
- **Go**: `gopls`
- **HTML**: `html`, `emmet_ls`
- **JavaScript/TypeScript**: `ts_ls`
- **JSON**: `jsonls`
- **Lua**: `lua_ls`
- **Python**: `pyright`
- **Rust**: `rust_analyzer`
- **Terraform**: `terraformls`
- **YAML**: `yamlls`

### Adding New LSP Servers

1. **Check available servers**:

   ```
   :Mason
   ```

2. **Add to configuration**: Edit `lua/plugins/lsp.lua` and add the server name to the `ensure_installed` table.

3. **Configure the server**: Add server-specific configuration in the `servers` table in the same file.

### LSP Features

- **Auto-completion**: `<C-Space>` to trigger, `<CR>` to accept
- **Go to definition**: `gd`
- **Go to references**: `gr`
- **Hover documentation**: `K`
- **Code actions**: `<leader>ca`
- **Rename symbol**: `<leader>rn`
- **Format document**: `<leader>f`

## Key Mappings

### Leader Key

The leader key is set to `<Space>`.

### Essential Mappings

- `<leader>pf` - Find files (Telescope)
- `<leader>pg` - Live grep (Telescope)
- `<leader>pb` - Browse buffers
- `<leader>f` - Format current file
- `<leader>u` - Toggle undo tree
- `<leader>gs` - Git status (fugitive)
- `<Ctrl-t><Ctrl-t>` - Toggle terminal

### Window Management

- `<leader>vs` - Vertical split
- `<leader>hs` - Horizontal split

### Git Integration

- `<leader>gp` - Preview hunk
- `<leader>gt` - Toggle line blame
- `<leader>gs` - Stage hunk

## File Structure

```
~/.config/nvim/
├── init.lua              # Main configuration file
├── lazy-lock.json        # Plugin version lockfile
└── lua/
    └── plugins/
        ├── copilot.lua   # GitHub Copilot configuration
        ├── core.lua      # Core dependencies
        ├── editor.lua    # Editor enhancements
        ├── format.lua    # Formatting configuration
        ├── git.lua       # Git integration
        ├── lsp.lua       # Language server configuration
        ├── telescope.lua # Fuzzy finder configuration
        ├── treesitter.lua# Syntax highlighting
        └── ui.lua        # UI themes and statusline
```

## Customization

### Changing Colorscheme

Edit `lua/plugins/ui.lua` and modify the colorscheme setup, or uncomment alternative themes like Rose Pine or Kanagawa.

### Adding New Plugins

Add new plugin specifications to the appropriate file in `lua/plugins/` or create a new file following the existing pattern.

### Modifying Key Mappings

Key mappings are defined in `init.lua` and individual plugin configuration files. Modify these to suit your preferences.

## Troubleshooting

### Plugin Issues

```bash
# Remove plugin cache and reinstall
rm -rf ~/.local/share/nvim
nvim
```

### LSP Issues

```bash
# Check LSP status
:LspInfo

# Restart LSP
:LspRestart
```

### Copilot Issues

```bash
# Check Copilot status
:Copilot status

# Re-authenticate
:Copilot setup
```

## Contributing

Feel free to fork this configuration and adapt it to your needs. If you find improvements or bug fixes, pull requests are welcome!
