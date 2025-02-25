return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "go",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "sql",
        "toml",
        "twig",
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
