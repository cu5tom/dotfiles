-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder
  -- Color scheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.gruvbox-baby" },
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-paper-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.colorscheme.nord-nvim" },
  { import = "astrocommunity.colorscheme.nordic-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  -- Docker
  { import = "astrocommunity.docker.lazydocker" },
  -- Editing support
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.multiple-cursors-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.vim-doge" },
  -- File explorer
  { import = "astrocommunity.file-explorer.oil-nvim" },
  -- Fuzzy finder
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },
  -- Git
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.gitgraph-nvim" },
  -- Icon
  { import = "astrocommunity.icon.mini-icons" },
  -- Lsp
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  -- Motion
  { import = "astrocommunity.motion.harpoon" },
  -- Pack
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.yaml" },
  -- Snippet
  { import = "astrocommunity.snippet.mini-snippets" },
  -- Syntax
  { import = "astrocommunity.syntax.hlargs-nvim" },
  -- Terminal integration
  { import = "astrocommunity.terminal-integration.vim-tmux-yank" },
  -- Utility
  -- { import = "astrocommunity.utility.hover-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
}
