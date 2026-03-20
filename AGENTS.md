# AGENTS.md - Development Guidelines for Dotfiles Repository

## Repository Overview

This is a dotfiles repository managed with GNU Stow. It contains configurations for:
- **Neovim** (`nvim/`) - Main IDE with lazy.nvim plugin manager
- **Fish Shell** (`fish/`) - Shell configuration
- **Bash** (`bash/`) - Shell aliases and environment
- **Tmux** (`tmux/`) - Terminal multiplexer
- **Starship** (`starship/`) - Cross-shell prompt
- **Yazi** (`yazi/`) - File manager
- **Lazygit** (`lazygit/`) - TUI for git
- **Sesh** (`sesh/`) - Session manager
- **Ripgrep** (`ripgrep/`) - Search tool
- **OpenCode** (`opencode/`) - AI coding assistant

## Build/Lint/Test Commands

This repository contains dotfiles and Neovim configuration. No traditional build/test commands exist.

### Setup/Deployment
```bash
./setup.sh          # Deploy dotfiles via GNU Stow
./setup.fish        # Alternative using Fish shell
```

### Formatting (Neovim)
- **Format current buffer**: `<leader>bf` in Neovim (conform.nvim)
- **Format Lua files**: `stylua <file>` (uses mason-installed stylua)
- **Format JS/TS/Vue**: `oxfmt <file>` (via nvim-lspconfig)
- **Format PHP**: `php-cs-fixer` (via nvim-lspconfig)

### Linting
- **Lint Lua**: `selene --config nvim/dot-config/nvim/selene.toml <file>`
- **Lint JS/TS/Vue**: `oxlint <file>` (via nvim-lint)

### Neovim Development
```bash
# Execute current buffer (in Neovim)
<Space><Space>x  -- Save and source current file

# Reinstall plugins
:Lazy sync
```

## Code Style Guidelines

### Lua (Neovim Configuration)
- **Formatter**: stylua (2-space indentation, 120 column width)
- **Linter**: selene with `std = "neovim"` (see `nvim/selene.toml`)
- **Type annotations**: EmmyLua format (e.g., `---@type LazySpec`, `---@class Foo`)
- **Imports**: Use `require()` for modules
- **Naming**:
  - Variables/functions: `camelCase`
  - Modules/classes/tables returning specs: `PascalCase`
  - Private module functions: prefix with `M.` in `local M = {}` pattern
- **Error handling**: Use `assert()` or `error()` for unrecoverable failures
- **Key guidelines from selene.toml**:
  - `global_usage = "allow"` (vim globals allowed)
  - `if_same_then_else = "allow"`
  - `mixed_table = "allow"`

### JavaScript/TypeScript/Vue
- **Formatter**: oxfmt (via LSP)
- **Linter**: oxlint (currently enabled)
- **Imports**: ES6 import/export syntax
- **Naming**: camelCase for variables/functions, PascalCase for components
- **Types**: TypeScript with strict typing when possible

### General
- **Line endings**: Unix (LF)
- **Indentation**: 2 spaces (Lua), varies for other languages
- **Quotes**: Double quotes preferred for strings
- **No trailing whitespace**
- **No unused variables/imports**

## Neovim Configuration Structure

```
nvim/dot-config/nvim/
├── init.lua                 # Entry point, lazy.nvim setup
├── selene.toml             # Lua linter config
├── lazy-lock.json          # Plugin lockfile
└── lua/
    ├── core/
    │   ├── options.lua      # Neovim options (vim.opt)
    │   ├── keymaps.lua      # Global keymaps
    │   ├── augroups.lua     # Autocommand groups
    │   ├── config.lua       # Runtime config (diagnostics, highlights)
    │   └── utils.lua        # Utility functions
    └── plugins/
        ├── ai.lua           # OpenCode AI assistant
        ├── lsp.lua          # LSP configuration
        ├── completion.lua   # blink.cmp
        ├── formatting.lua   # conform.nvim
        ├── linting.lua      # nvim-lint
        ├── snacks.lua       # snacks.nvim
        ├── git.lua          # Git integration
        ├── debugging.lua    # DAP configuration
        ├── db.lua           # Database tools
        └── editor/
            ├── keymaps.lua  # Which-key bindings
            ├── statusline.lua # lualine config
            └── ...
```

### Plugin Patterns (lazy.nvim)
```lua
---@type LazySpec
return {
  {
    "author/plugin",
    dependencies = { "dep1", { "dep2", opts = {} } },
    event = "VeryLazy",  -- or ft = "lua", or cmd = "Command"
    opts = {},           -- or config = function() end
    keys = {},           -- for keymap-style lazy loading
  },
}
```

## Git Conventions

- **Default branch**: `master`
- **Diff algorithm**: histogram with `linematch:60`
- **Rebase**: autosquash, autostash, updateRefs enabled
- **Push**: simple default with autoSetupRemote

## Tmux Integration

- **Plugin manager**: tpm (tmux-plugins/tpm)
- **Plugins**: tmux-sensible, tmux-continuum, tmux-resurrect, tmux-nova
- **Keybindings** (tmux-nova):
  - `C-o`: Toggle OpenCode interface
  - `O`: Show OpenCode help
  - `C-O`: Session management panel
  - `M-o`: Send pane content to OpenCode
  - `C-M-o`: Send git status to OpenCode
  - `M-O`: Analyze project structure

## OpenCode AI Assistant

### Keybindings (Neovim)
- **Core**: `<leader>oa` (ask), `<leader>os` (select), `<leader>o+` (add)
- **Lua/Neovim**: `<leader>old` (debug), `<leader>olo` (optimize), `<leader>olp` (review)
- **Dotfiles**: `<leader>oda` (audit), `<leader>oco` (optimize), `<leader>osh` (shell)
- **Workflow**: `<leader>ogw` (git), `<leader>ots` (testing), `<leader>osa` (security)
- **Session**: `<leader>ot` (toggle), `<leader>oc` (command), `<leader>on` (new)

### Custom Prompts (see `lua/plugins/ai.lua`)
- `lua_debug`: Debug Lua/Neovim code for common issues
- `lua_optimize`: Optimize for performance and readability
- `lua_document`: EmmyLua annotation documentation
- `dotfiles_audit`: Security and best practices audit
- `git_workflow`: Analyze git workflow improvements
- `performance_profile`: Performance bottleneck analysis

### Available Skills
- **grill-me**: Stress-test plans and designs via relentless questioning

## Important Notes

1. **Do NOT commit secrets**: Never add `.env`, credentials, or API keys
2. **Stow structure**: All configs live in `*/dot-config/*/` subdirectories
3. **Mason packages**: LSPs and formatters installed via `nvim/dot-config/nvim/lua/plugins/lsp.lua`
4. **Plugin updates**: Run `:Lazy sync` in Neovim after adding/removing plugins
