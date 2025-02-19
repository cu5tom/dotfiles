-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "html",
      "lua",
      "markdown",
      "markdown_inline",
      "regex",
      "sql",
      "toml",
      "typescript",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
