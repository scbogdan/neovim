# Neovim Configuration

A modern, modular Neovim configuration focused on development workflows with LSP support, intelligent completion, and powerful editing features.

## Overview

This configuration provides:

- **LSP Integration**: Full language server support with Mason for easy management
- **Intelligent Completion**: Context-aware autocomplete with nvim-cmp
- **Code Formatting**: Automatic formatting with conform.nvim and language-specific tools
- **Git Integration**: Gitsigns for diff viewing and Fugitive for Git operations
- **Fuzzy Finding**: Telescope for files, buffers, and project-wide search
- **Syntax Highlighting**: TreeSitter for accurate syntax highlighting
- **Terminal Integration**: Built-in terminal with ToggleTerm
- **GitHub Copilot**: AI-powered code suggestions

## System Requirements

### macOS Prerequisites

```bash
# Neovim (version 0.8+ required)
brew install neovim

# Essential tools for plugin functionality
brew install git curl unzip

# Search tools for Telescope
brew install ripgrep fd

# Node.js (required for some LSP servers and formatters)
brew install node # or use Node Version Manager (nvm)

# Optional: For better Git integration
brew install lazygit

# Python support (if you develop in Python)
python3 -m pip install --user --upgrade pynvim black
```

### System Requirements

- **Neovim**: 0.8.0 or later
- **Git**: For plugin management and version control features
- **Node.js**: v16+ (required for TypeScript/JavaScript LSP and some formatters)
- **Python**: 3.6+ with pip (for Python development and some plugins)

## Installation Steps

### 1. Backup Existing Configuration

```bash
# Backup your current config (if it exists)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### 2. Clone This Configuration

```bash
# Clone the repository
git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim

# Navigate to the config directory
cd ~/.config/nvim
```

### 3. First Launch

```bash
# Start Neovim - plugins will install automatically
nvim
```

**Note**: The first startup will take a few minutes as lazy.nvim downloads and installs all plugins.

## Post-Installation Setup

### 1. Wait for Plugin Installation

On first launch, lazy.nvim will automatically:

- Download and install all plugins
- Compile TreeSitter parsers
- Set up the plugin environment

### 2. Install LSP Servers and Tools

Open Neovim and run:

```vim
:Mason
```

The following tools will be automatically installed via Mason:

- **Language Servers**: bashls, dockerls, gopls, lua_ls, pyright, rust_analyzer, ts_ls, yamlls, jsonls, html
- **Additional tools**: You can install formatters and linters as needed

### 3. Configure GitHub Copilot (Optional)

If you want to use GitHub Copilot:

```vim
:Copilot setup
```

Follow the authentication prompts to link your GitHub account.

## LSP and Tool Management

### Using Mason

Mason provides a unified interface for managing LSP servers, formatters, and linters:

```vim
:Mason                 " Open Mason UI
:MasonInstall <tool>   " Install a specific tool
:MasonUninstall <tool> " Remove a tool
:MasonUpdate          " Update all installed tools
```

### Pre-configured Language Servers

The following language servers are automatically installed:

| Language              | Server                                    | Notes                                   |
| --------------------- | ----------------------------------------- | --------------------------------------- |
| Bash/Shell            | bashls                                    | Shell scripting support                 |
| Docker                | dockerls, docker_compose_language_service | Docker and compose files                |
| Go                    | gopls                                     | Go development with formatting          |
| HTML                  | html, emmet_ls                            | Web development                         |
| JavaScript/TypeScript | ts_ls                                     | Node.js and web development             |
| JSON                  | jsonls                                    | Configuration files                     |
| Lua                   | lua_ls                                    | Neovim configuration                    |
| Python                | pyright                                   | Python development                      |
| Rust                  | rust_analyzer                             | Rust development                        |
| Terraform             | terraformls                               | Infrastructure as code                  |
| YAML                  | yamlls                                    | Configuration files with schema support |

### Essential Tools Installation

Install these additional formatters and linters through Mason as needed:

```vim
" Code formatters
:MasonInstall prettier     " JavaScript/TypeScript/JSON/YAML/Markdown
:MasonInstall stylua       " Lua formatting
:MasonInstall shfmt        " Shell script formatting
:MasonInstall black        " Python formatting (or install via pip)

" Linters
:MasonInstall eslint_d     " JavaScript/TypeScript linting
:MasonInstall shellcheck   " Shell script linting
```

## Plugin Management Basics

### Using lazy.nvim

```vim
:Lazy                 " Open lazy.nvim UI
:Lazy update         " Update all plugins
:Lazy sync           " Install missing and update existing plugins
:Lazy clean          " Remove unused plugins
:Lazy profile        " View startup time profiling
```

### Adding New Plugins

1. Create a new file in `lua/plugins/` or edit an existing one
2. Add your plugin specification:

```lua
return {
    "author/plugin-name",
    config = function()
        -- Plugin configuration
    end,
}
```

3. Restart Neovim or run `:Lazy sync`

### Removing Plugins

1. Remove or comment out the plugin from your configuration files
2. Run `:Lazy clean` to remove unused plugins

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point with basic settings and keymaps
├── lazy-lock.json          # Plugin version lockfile
└── lua/
    └── plugins/            # Modular plugin configurations
        ├── color.lua       # Color schemes (rose-pine)
        ├── copilot.lua     # GitHub Copilot integration
        ├── core.lua        # Essential dependencies
        ├── editor.lua      # Editor enhancements (comments, autopairs, etc.)
        ├── format.lua      # Code formatting (conform.nvim)
        ├── git.lua         # Git integration (gitsigns, fugitive)
        ├── lsp.lua         # LSP configuration and language servers
        ├── telescope.lua   # Fuzzy finder and search
        ├── treesitter.lua  # Syntax highlighting
        └── ui.lua          # UI enhancements (statusline, indent guides)
```

### File Organization

- **`init.lua`**: Contains core Neovim settings, keymaps, and autocommands
- **`lua/plugins/`**: Each file focuses on a specific feature area:
  - `lsp.lua`: Complete LSP setup with all language servers
  - `telescope.lua`: File finding and project search
  - `git.lua`: Git workflow tools
  - `format.lua`: Code formatting rules and tools
  - `ui.lua`: Visual enhancements and status line

## Essential Tools Installation

### For Python Development

```bash
pip install black ruff mypy
:MasonInstall pyright black ruff
```

### For JavaScript/TypeScript Development

```bash
npm install -g prettier eslint
:MasonInstall ts_ls prettier eslint_d
```

### For Go Development

```bash
go install golang.org/x/tools/gopls@latest
:MasonInstall gopls
```

### For Rust Development

```bash
rustup component add rust-analyzer
:MasonInstall rust_analyzer
```

## Troubleshooting Setup Issues

### Plugin Installation Issues

```vim
" If plugins fail to install:
:Lazy clear          " Clear plugin cache
:Lazy restore        " Restore from lockfile
:Lazy sync           " Reinstall everything
```

### LSP Server Issues

```vim
" Check LSP server status:
:LspInfo             " Show attached language servers
:Mason               " Check installed tools
:checkhealth         " General health check

" Restart LSP servers:
:LspRestart
```

### Common Issues

**1. Node.js not found**

```bash
# Install Node.js via Homebrew
brew install node
# Or use Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

**2. Python LSP not working**

```bash
# Install Python support
python3 -m pip install --user pynvim
:MasonInstall pyright
```

**3. Telescope not finding files**

```bash
# Install required search tools
brew install ripgrep fd
```

**4. Copilot authentication issues**

```vim
:Copilot auth        " Re-authenticate
:Copilot status      " Check status
```

**5. TreeSitter parsing errors**

```vim
:TSUpdate            " Update all parsers
:TSInstall <language> " Install specific parser
```

### Performance Issues

If Neovim starts slowly:

```vim
:Lazy profile        " Check plugin loading times
```

Consider lazy-loading plugins that aren't immediately needed by adding `lazy = true` or specific triggers to plugin specifications.

### Getting Help

- `:help <topic>` - Built-in Neovim help
- `:checkhealth` - Comprehensive system health check
- `:LspInfo` - LSP server information
- `:Mason` - Tool installation status
