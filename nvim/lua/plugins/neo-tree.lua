-- local wk = require("which-key")
-- TODO: update neo-tree buffer aufter lazygit close
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
      "nvim-tree/nvim-web-devicons",
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
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
            group_empty_dirs = true,
            show_unloaded = true
          }
        }
      })

      -- wk.add({ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" })
    end
  }
}
