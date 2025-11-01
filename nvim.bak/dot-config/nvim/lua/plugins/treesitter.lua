return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function ()
          require("nvim-ts-autotag").setup({})
        end
      },
      -- {
      --   "nvim-treesitter/nvim-treesitter-textobjects"
      -- },
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
        indent = {
          enable = true,
        },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = "<C-y>",
        --     node_incremental = "<C-y>",
        --     node_decremental = "<bs>",
        --     scope_incremental = false,
        --   },
        -- },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   lazy = true,
  --   config = function ()
  --     require("nvim-treesitter.configs").setup({
  --       textobjects = {
  --         select = {
  --           enable = true,
  --           lookahead = true,
  --           keymaps = {
  --             ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
  --             ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
  --             ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
  --             ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
  --             ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
  --             ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
  --             ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
  --             ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
  --             ["l="] = { query = "@assignment.lhs", desc = "Select lhs of a assignment region" },
  --             ["r="] = { query = "@assignment.rhs", desc = "Select rhs of a assignment region" },
  --           }
  --         },
  --       }
  --     })
  --   end
  -- },
  -- {
  --   "davidmh/mdx.nvim",
  --   config = true,
  --   dependencies = {"nvim-treesitter/nvim-treesitter"}
  -- }
}
