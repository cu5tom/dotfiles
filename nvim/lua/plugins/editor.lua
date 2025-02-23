---@type LazySpec
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function ()
      require("ibl").setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "RRethy/vim-illuminate"
  },
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "stevearc/resession.nvim"
    },
    config = function()
      local get_hex = require("cokeline.hlgroups").get_hl_attr
      local yellow = vim.g.terminal_color_3

      require("cokeline").setup({
        default_hl = {
          fg = function (buffer)
            return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
          end,
          bg = function ()
            return get_hex("ColorColumn", "bg")
          end
        },
        sidebar = {
          filetype = { "NvimTree", "neo-tree" },
          components = {
            {
              text = function (buf)
                return buf.filetype
              end,
              fg = yellow,
              bg = function ()
                return get_hex("NvimTreeNormal", "bg")
              end,
              bold = true
            }
          }
        },
        components = {
          {
            text = function (buf)
              return (buf.index ~= 1) and "|" or ""
            end,
          },
          {
            text = " "
          },
          {
            text = function (buf)
              return buf.devicon.icon
            end,
            fg = function (buf)
              return buf.devicon.color
            end
          },
          {
            text = " "
          },
          {
            text = function (buf)
              return buf.filename .. " "
            end,
            bold = function (buf)
              return buf.is_focused
            end
          },
          {
            text = "x",
            on_click = function (_, _, _, _, buf)
              buf:delete()
            end
          },
          {
            text = " "
          }
        }
      })
    end
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   dependencies = {
  --     "moll/vim-bbye",
  --     "nvim-tree/nvim-web-devicons",
  --     "nvim-tree/nvim-tree.lua"
  --   },
  --
  --   -- event = { "BufNewFile", "BufReadPost" },
  --   config = function()
  --     require("bufferline").setup({
  --       options = {
  --         mode = "buffers",
  --         themable = true,
  --         close_command = "Bdelete! %d",
  --         right_mouse_command = "Bdelete! %d",
  --         left_mouse_command = "buffer %d",
  --         middle_mouse_command = nil,
  --         -- buffer_close_icon = "X",
  --         -- close_icon = "X",
  --         path_components = 1,
  --         -- modified_icon = "m",
  --         -- left_trunc_marker = ""
  --         -- right_trunc_marker = ""
  --         max_name_length = 30,
  --         max_prefix_length = 30,
  --         tab_size = 21,
  --         -- diagnostics = true,
  --         -- diagnostics_update_in_insert = false,
  --         -- diagnostics_indicator = function(count, level)
  --         --   local icon = level:match("error") and " " or " "
  --         --   return " " .. icon .. count
  --         -- end,
  --         -- color_icons = true,
  --         -- show_buffer_icons = true,
  --         -- show_buffer_close_icons = true,
  --         -- show_close_icon = true,
  --         -- persist_buffer_sort = true,
  --         -- separattor_style = { "|", "|" },
  --         -- enforce_regular_taps = true,
  --         -- always_show_bufferline = false,
  --         -- show_tab_indicators = false,
  --         -- indicator = { style = "none" },
  --         -- icon_pinned = ""
  --         -- minimum_padding = 1,
  --         -- maximum_padding = 5,
  --         -- maximum_length = 15,
  --         -- sort_by = "insert_at_end",
  --         offsets = {
  --           filetype = "neo-tree",
  --           text = "File Explorer",
  --           highlight = "Directory",
  --           -- text_align = "left"
  --         },
  --       },
  --       highlights = {
  --         separator = {
  --           fg = "#434c5e"
  --         },
  --         buffer_selected = {
  --           bold = true,
  --           italic = false,
  --         },
  --         -- separator_selected = {}
  --         -- tab_selected = {}
  --         -- background = {}
  --         -- indicator_selected = {}
  --         -- fill = {}
  --       }
  --     })
  --   end
  -- },
  {
    "nvim-lualine/lualine.nvim",
    config = function ()
      local colors = {}

      local mode = {
        "mode",
        fmt = function (str)
          return str
        end
      }

      local filename = {
        "filename",
        file_status = true,
        path = 0
      }

      local hide_in_width = function ()
        return vim.fn.winwidth(0) > 100
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = "e", warn = "w", info = "i", hint = "h" },
        colored = false,
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width
      }

      local diff = {
        "diff",
        colored = false,
        symbols = { added = "a", modified = "m", removed = "r" },
        cond = hide_in_width
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "nord",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { "neo-tree" },
          always_devide_middle = true
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch" },
          lualine_c = { filename },
          lualine_x = { diagnostics, diff, { "encoding", cond = hide_in_width }, { "filetype", cond = hide_in_width } },
          lualine_y = { "location" },
          lualine_z = { "progress" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { { "location", padding = 0 } },
          lualine_y = {},
          lualine_z = {},
        }
      })
    end
  }
}
