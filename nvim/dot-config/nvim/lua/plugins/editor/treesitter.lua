return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    -- event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
    },
    init = function ()
      vim.wo.foldlevel = 99
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
    config = function()
      local treesitter = require "nvim-treesitter"

      treesitter.setup {
        auto_install = true,
        ensure_installed = {
          "bash",
          "comment",
          "css",
          "dockerfile",
          "gitignore",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "regex",
          "scss",
          "sql",
          "toml",
          "tsx",
          "twig",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        highlight = {
          enable = true,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  },
}

