
---@type LazySpec
return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim"
    },
    config = function ()
      require("lsp-file-operations").setup()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function ()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" }
              }
            }
          })
        end
      }
    },
    config = function ()
      require("neo-tree").setup({
        commands = {},
        filesystem = {
          follow_current_file = {
            enabled = true
          },
          window = {
            mappings = {}
          }
        },
        source_selector = {
          winbar = true
        },
        window = {
          mappings = {
            ["<space>"] = false
          }
        },
      })
    end
  }
}
