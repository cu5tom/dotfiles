# AGENTS.md - Development Guidelines for Dotfiles Repository

## Build/Lint/Test Commands

This repository contains dotfiles and Neovim configuration. No traditional build/test commands exist.

### Formatting
- **Format current buffer**: `<leader>bf` in Neovim (conform.nvim)
- **Format Lua files**: `stylua --config-path nvim/dot-config/nvim/.stylua.toml <file>`
- **Format JS/TS/Vue**: `biome format --write <file>`
- **Format CSS/SCSS**: `prettierd <file>`

### Linting
- **Lint JS/TS/Vue**: `oxlint <file>` (currently disabled in config)
- **Lint Lua**: `selene --config nvim/dot-config/nvim/selene.toml <file>`

## Code Style Guidelines

### Lua
- **Formatter**: stylua with 2-space indentation, 120 column width
- **Linter**: selene with neovim std library
- **Imports**: Use `require()` for modules
- **Naming**: camelCase for variables, PascalCase for modules/classes
- **Error handling**: Use `assert()` or `error()` for failures

### JavaScript/TypeScript/Vue
- **Formatter**: biome (when enabled)
- **Linter**: oxlint (when enabled)
- **Imports**: ES6 import/export syntax
- **Naming**: camelCase for variables/functions, PascalCase for components
- **Types**: Use TypeScript with strict typing when possible

### General
- **Line endings**: Unix (LF)
- **Indentation**: 2 spaces (except where language dictates otherwise)
- **Quotes**: Double quotes preferred for strings
- **No trailing whitespace**
- **No unused variables/imports**

### Neovim Configuration
- **Plugin manager**: lazy.nvim
- **Completion**: blink.cmp
- **LSP**: mason-managed servers (typescript, lua_ls, etc.)
- **File operations**: Follow existing plugin patterns in lua/plugins/

### OpenCode AI Assistant Integration
- **Statusline**: Shows current OpenCode state with click-to-toggle functionality
- **Custom Prompts**: Specialized prompts for Neovim/Lua development and dotfiles management
- **Keybindings**:
  - **Core**: `<leader>oa` (ask), `<leader>os` (select), `<leader>o+` (add)
  - **Lua/Neovim**: `<leader>old` (debug), `<leader>olo` (optimize), `<leader>olp` (review)
  - **Dotfiles**: `<leader>oda` (audit), `<leader>oco` (optimize), `<leader>osh` (shell)
  - **Workflow**: `<leader>ogw` (git), `<leader>ots` (testing), `<leader>osa` (security)
  - **Session**: `<leader>ot` (toggle), `<leader>oc` (command), `<leader>on` (new)

### Tmux Integration
- **OpenCode AI Assistant**: Enhanced popup integration with smart session detection
- **Keybindings**:
  - `C-o`: Toggle OpenCode interface (auto-detects running instances)
  - `O`: Show OpenCode help and available commands
  - `C-O`: OpenCode session management panel
  - `M-o`: Send current pane content to OpenCode for analysis
  - `C-M-o`: Send git status to OpenCode
  - `M-O`: Analyze entire project structure with OpenCode
- **Status indicator**: Shows 🤖 when in OpenCode pane
- **Popup styling**: Rounded borders, responsive sizing (85-95% of screen)</content>
<parameter name="filePath">AGENTS.md