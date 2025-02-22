---@type LazySpec[]
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "astro",
        "cssls",
        "emmet_ls",
        "html",
        "jinja_lsp",
        "jsonls",
        "lua_ls",
        "marksman",
        "mdx_analyzer",
        "phpactor",
        "somesass_ls",
        "ts_ls",
        "volar",
        "yamlls"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "LazyNvim", words = { "LazyNvim" } },
            { path = "lazy.nvim", words = { "LazyNvim" } }
          }
        }
      }
    },
    config = function()
      local lsp = require("lspconfig")
      lsp.lua_ls.setup({})

      lsp.ts_ls.setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
              languages = {"javascript", "typescript", "vue"},
            }
          }
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })

      lsp.volar.setup({})
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function ()
      require("lspsaga").setup({
        lightbulb = {
          enable = false
        }
      })
    end
  }
}
