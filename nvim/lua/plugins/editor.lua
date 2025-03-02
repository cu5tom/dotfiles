---@type LazySpec
--- dsfasfdsafdasfdsaf
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      local todo_comments = require "todo-comments"

      vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" })

      todo_comments.setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    },
    config = function() vim.notify = require "notify" end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "stevearc/resession.nvim",
    },
    config = function()
      local get_hex = require("cokeline.hlgroups").get_hl_attr
      local yellow = vim.g.terminal_color_3

      require("cokeline").setup {
        default_hl = {
          fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
          bg = function() return get_hex("ColorColumn", "bg") end,
        },
        sidebar = {
          filetype = { "NvimTree", "neo-tree" },
          components = {
            {
              text = function(buf) return buf.filetype end,
              fg = yellow,
              bg = function() return get_hex("NvimTreeNormal", "bg") end,
              bold = true,
            },
          },
        },
        components = {
          {
            text = function(buf) return (buf.index ~= 1) and "|" or "" end,
          },
          {
            text = " ",
          },
          {
            text = function(buf) return buf.devicon.icon end,
            fg = function(buf) return buf.devicon.color end,
          },
          {
            text = " ",
          },
          {
            text = function(buf) return buf.filename .. " " end,
            bold = function(buf) return buf.is_focused end,
          },
          {
            text = "x",
            on_click = function(_, _, _, _, buf) buf:delete() end,
          },
          {
            text = " ",
          },
        },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lazy_status = require "lazy.status"
      local colors = {}

      local mode = {
        "mode",
        fmt = function(str) return str end,
      }

      local filename = {
        "filename",
        file_status = true,
        path = 0,
      }

      local hide_in_width = function() return vim.fn.winwidth(0) > 100 end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = "\u{ea87}", warn = "\u{f071}", info = "\u{f129}" },
        colored = false,
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width,
      }

      local diff = {
        "diff",
        colored = false,
        symbols = { added = "\u{eadc}", modified = "\u{eade}", removed = "\u{eadf}" },
        cond = hide_in_width,
      }

      local lsp_clients = {
        "lsp_clients",
        fmt = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.buf_get_clients(bufnr)
          if next(clients) == nil then return "" end

          local c = {}
          for _, client in pairs(clients) do
            table.insert(c, client.name)
          end
          return "\u{f085} " .. table.concat(c, "|")
        end,
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width,
      }

      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "nord",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { "neo-tree" },
          always_devide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch" },
          lualine_c = { filename },
          lualine_x = {
            lsp_clients,
            diagnostics,
            diff,
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding", cond = hide_in_width },
            { "filetype", cond = hide_in_width },
          },
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
        },
      }
    end,
  },
}
