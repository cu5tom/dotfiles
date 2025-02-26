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
      "folke/todo-comments.nvim"
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

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find existing buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent" })
      vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Find resume" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor in cwd" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find word in cwd" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
      vim.keymap.set("n", "<leader>fn", function() 
        builtin.find_files({ cwd = vim.fn.stdpath("config")}) 
      end, { desc = "Find Neovim files" })
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todo"})
    end
  }
}
