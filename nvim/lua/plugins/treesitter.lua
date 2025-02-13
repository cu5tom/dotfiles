-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "lua",
      "markdown",
      "markdown_inline",
      "regex",
      "sql",
      "typescript",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
