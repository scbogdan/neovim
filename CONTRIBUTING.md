# Contributing to Neovim Configuration

Thank you for your interest in contributing! This project maintains high standards for code quality and follows professional development practices.

## Quick Start

1. **Fork and clone the repository**

   ```bash
   git clone https://github.com/yourusername/neovim.git
   cd neovim
   ```

2. **Install development dependencies**

   ```bash
   # Install Node.js dependencies
   pnpm install

   # Install luacheck for Lua linting
   # macOS
   brew install luacheck

   # Ubuntu/Debian
   sudo apt-get install luacheck

   # Or via luarocks
   luarocks install luacheck
   ```

3. **Test your setup**

   ```bash
   # Run linting
   pnpm lint:lua

   # Test commit message validation
   pnpm commitlint
   ```

## Development Workflow

### Code Quality Standards

All contributions must pass our quality gates:

- **Lua Linting**: Code must pass `luacheck` with no warnings
- **Pre-commit Hooks**: Automated checks run before each commit
- **Conventional Commits**: All commits must follow conventional commit format
- **CI/CD**: All pull requests must pass GitHub Actions checks

### Making Changes

1. **Create a feature branch**

   ```bash
   git checkout -b feat/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

2. **Make your changes**

   - Edit files in `lua/plugins/` for plugin configurations
   - Update `init.lua` for core settings
   - Add documentation if needed

3. **Test locally**

   ```bash
   # Lint your Lua code
   pnpm lint:lua

   # Test in Neovim
   nvim
   ```

4. **Commit with conventional format**
   ```bash
   git add .
   git commit -m "feat: add telescope extension for better search"
   # or
   git commit -m "fix: resolve lsp keybinding conflict"
   ```

### Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/) for automatic changelog generation:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**

- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks
- `revert`: Reverting changes

**Examples:**

```bash
feat(lsp): add rust-analyzer configuration
fix(telescope): resolve hidden files search issue
docs: update keybinding documentation
refactor(ui): improve lualine performance
chore: update dependencies
```

### Pull Request Guidelines

1. **Before submitting:**

   - Ensure all tests pass locally
   - Run `pnpm lint:lua` with no errors
   - Test the configuration in a fresh Neovim instance
   - Update documentation if needed

2. **PR Description should include:**

   - Clear description of changes
   - Motivation for the change
   - Screenshots/demos if UI changes
   - Testing instructions
   - Breaking changes (if any)

3. **Use the PR template:**
   - Fill out all sections of `.github/PULL_REQUEST_TEMPLATE.md`
   - Check appropriate boxes for type of change
   - Link related issues

## Development Guidelines

### Code Style

**Lua Code:**

- Use 4 spaces for indentation
- Maximum line length: 140 characters
- Follow luacheck rules (see `.luacheckrc`)
- Use descriptive variable names
- Add comments for complex logic

**File Organization:**

- Plugin configs go in `lua/plugins/`
- Group related plugins in the same file
- Use descriptive filenames (e.g., `lsp.lua`, `telescope.lua`)

### Adding New Plugins

1. **Choose the right file:**

   ```
   lua/plugins/
   ├── lsp.lua        # Language servers & completion
   ├── telescope.lua  # Fuzzy finder & search
   ├── git.lua        # Git integration
   ├── ui.lua         # Themes, statusline, UI
   ├── editor.lua     # Editor enhancements
   ├── format.lua     # Code formatting
   └── core.lua       # Essential dependencies
   ```

2. **Plugin configuration template:**

   ```lua
   return {
       "author/plugin-name",
       -- Optional: specify version for stability
       version = "v1.0.0",

       -- Optional: lazy loading conditions
       event = "VeryLazy",
       cmd = "PluginCommand",
       ft = { "lua", "python" },

       -- Dependencies
       dependencies = {
           "required/dependency",
       },

       -- Configuration
       config = function()
           require("plugin-name").setup({
               -- Plugin options
           })

           -- Keymaps (if any)
           vim.keymap.set("n", "<leader>key", "<cmd>Command<CR>",
               { desc = "Description" })
       end,
   }
   ```

### Testing Changes

1. **Test in clean environment:**

   ```bash
   # Backup your config
   mv ~/.config/nvim ~/.config/nvim.backup

   # Test the new config
   git clone your-fork ~/.config/nvim
   nvim
   ```

2. **Test specific functionality:**

   - LSP: `:LspInfo`, `:checkhealth lsp`
   - Plugins: `:Lazy`, `:Lazy profile`
   - Keybindings: Use Which-Key (`<Space>`)

3. **Performance testing:**
   ```vim
   :Lazy profile
   :checkhealth
   ```

## Reporting Issues

### Bug Reports

Include the following information:

1. **Environment:**

   - OS (macOS, Linux distribution, Windows)
   - Neovim version (`nvim --version`)
   - Terminal emulator

2. **Steps to reproduce:**

   - Detailed steps
   - Expected vs actual behavior
   - Error messages (if any)

3. **Diagnostic info:**
   ```vim
   :checkhealth
   :LspInfo
   :Lazy
   ```

### Feature Requests

- Describe the feature clearly
- Explain the use case and benefits
- Consider implementation complexity
- Check if similar functionality exists

## Advanced Development

### Local Testing Scripts

```bash
# Run full lint check
pnpm lint

# Test commit message format
echo "feat: test message" | pnpm commitlint

# Simulate pre-commit hook
pnpm lint-staged --config lint-staged.config.ts
```

### Debugging Plugin Issues

1. **Check plugin loading:**

   ```vim
   :Lazy
   ```

2. **Debug LSP issues:**

   ```vim
   :LspInfo
   :LspLog
   ```

3. **Check for conflicts:**
   ```vim
   :checkhealth
   ```

### Working with CI/CD

Our GitHub Actions automatically:

- Run luacheck on all Lua files
- Generate releases with semantic versioning
- Update changelog automatically
- Check conventional commit format

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Luacheck Documentation](https://luacheck.readthedocs.io/)

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help newcomers learn
- Keep discussions technical and relevant

## Project Goals

This configuration aims to:

- Provide a professional DevOps-focused development environment
- Maintain high code quality standards
- Support multiple programming languages and tools
- Be easy to understand and extend
- Follow modern Neovim best practices

## Getting Help

- **Issues**: For bugs and feature requests
- **Discussions**: For questions and general discussion
- **Documentation**: Check README.md and code comments
