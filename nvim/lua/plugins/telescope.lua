--local wk = require("which-key")

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function ()
          return vim.fn.executable "make" == 1
        end
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {},
    config = function ()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-l>"] = actions.select_default,
            },
            n = {
              ["q"] = actions.close
            }
          }
        },
        pickers = {
          find_files = {
            file_ignore_patterns = { ".git", ".venv" },
            hidden = true,
          },
          buffers = {
            initial_mode = "normal",
            sort_lastused = true,
            mappings = {
              n = {
                ["d"] = actions.delete_buffer,
              }
            }
          }
        },
        live_grep = {
          file_ignore_patterns = { ".git", ".venv" },
          additional_args = function ()
            return { "--hidden" }
          end
        },
        path_display = {
          filename_first = {
            reverse_directories = true,
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown()
          }
        },
        git_files = {
          previewer = false
        }
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")


    end
  }
}
