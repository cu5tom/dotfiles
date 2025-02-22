
---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function ()
      require("neo-tree").setup({
        commands = {
          -- run_command = function (state)
          --   local node = state.tree:get_node()
          --   local path = node:get_id()
          --   vim.api.nvim_input(":ls -la " .. path)
          -- end
        },
        filesystem = {
          follow_current_file = {
            enabled = true
          },
          window = {
            mappings = {
              -- ["i"] = "run_command"
            }
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
