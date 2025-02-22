return {
  {
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
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function ()
      require("treesitter-context").setup()
    end
  }
}
