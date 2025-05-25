# Neovim Configuration

A comprehensive Neovim configuration focused on DevOps and development workflows.
Includes LSP support for multiple languages (Python, Go, Rust, JavaScript/TypeScript,
Terraform, Docker, etc.), powerful fuzzy finding with Telescope,
Git integration with visual diffs and blame, GitHub Copilot support,
syntax highlighting, code formatting, and a clean UI with statusline and themes.

[![Lua](https://github.com/scbogdan/neovim/actions/workflows/lua.yaml/badge.svg)](https://github.com/scbogdan/neovim/actions/workflows/lua.yaml)
[![Semantic Release](https://github.com/scbogdan/neovim/actions/workflows/semantic-release.yaml/badge.svg)](https://github.com/scbogdan/neovim/actions/workflows/semantic-release.yaml)

## Table of Contents

- [Setup](#setup)
- [Learning Keybindings](#learning-keybindings)
- [Plugin Management](#plugin-management)
- [Development & Contributing](#development--contributing)
- [File Structure](#file-structure)
- [Quality Assurance](#quality-assurance)
- [Troubleshooting](#troubleshooting)

## Setup

### Prerequisites

- Neovim 0.9+
- Git
- Node.js
- luacheck (for development/contributing)

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

## Development & Contributing

This project uses professional development practices with automated quality checks.

**See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.**

### Code Quality

- **Lua Linting**: All Lua code is checked with [luacheck](https://github.com/lunarmodules/luacheck)
- **Pre-commit Hooks**: Code is automatically linted before commits
- **CI/CD**: GitHub Actions run luacheck on all pull requests
- **Conventional Commits**: Enforced via commitlint for consistent changelog generation

### Available Scripts

```bash
# Lint all Lua files
pnpm lint:lua

# Run all linters
pnpm lint

# Check commit message format
pnpm commitlint
```

### Quick Development Setup

```bash
# Install luacheck
brew install luacheck  # macOS
sudo apt-get install luacheck  # Ubuntu/Debian

# Install dependencies
pnpm install

# Test setup
pnpm lint:lua
```

### Git Workflow

- All commits must follow [conventional commit format](https://www.conventionalcommits.org/)
- Pre-commit hooks ensure code quality
- Semantic versioning with automated releases
- Changelog automatically updated

## File Structure

```
lua/plugins/
├── lsp.lua        # Language servers
├── telescope.lua  # Fuzzy finder
├── git.lua        # Git integration
├── ui.lua         # Themes & statusline
├── editor.lua     # Editor enhancements
├── format.lua     # Code formatting
└── core.lua       # Essential dependencies

.github/
├── workflows/
│   ├── lua.yaml             # Lua linting CI
│   └── semantic-release.yaml # Automated releases
├── CHANGELOG.md             # Auto-generated changelog
├── dependabot.yaml          # Dependency updates
└── PULL_REQUEST_TEMPLATE.md

.husky/                      # Git hooks
├── commit-msg              # Commit message validation
└── pre-commit              # Pre-commit linting

Configuration:
├── .luacheckrc             # Lua linting rules
├── commitlint.config.ts    # Commit message rules
├── lint-staged.config.ts   # Pre-commit hook config
├── .releaserc.json        # Semantic release config
└── CONTRIBUTING.md         # Contribution guidelines
```

## Quality Assurance

This configuration maintains high code quality through:

- **Automated Testing**: luacheck validates all Lua syntax and style
- **Git Hooks**: Pre-commit hooks prevent bad code from being committed
- **Continuous Integration**: GitHub Actions ensure all PRs pass quality checks
- **Dependency Management**: Dependabot keeps dependencies updated
- **Semantic Versioning**: Automated releases with proper version bumping
- **Documentation**: Comprehensive guides and inline code documentation

## Adding Keybindings

In `init.lua` or plugin config files:

```lua
vim.keymap.set("n", "<leader>my", "<cmd>MyCommand<CR>", { desc = "My command" })
```

## Troubleshooting

- `:checkhealth` - Check setup
- `:LspInfo` - Check language servers
- `:Lazy profile` - Check performance
- `pnpm lint:lua` - Check Lua code quality locally

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for:

- Development setup instructions
- Code style guidelines
- Testing procedures
- Pull request process
- Issue reporting guidelines

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
- [Which-Key for Keybinding Discovery](https://github.com/folke/which-key.nvim)
- [Mason for LSP Management](https://github.com/williamboman/mason.nvim)
