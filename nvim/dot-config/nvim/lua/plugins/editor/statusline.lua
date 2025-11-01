return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lazy_status = require "lazy.status"

      local mode = {
        "mode",
        fmt = function(str) return string.sub(str, 1, 1) end,
      }

      local filename = {
        "filename",
        file_status = true,
        path = 1,
      }

      local hide_in_width = function() return vim.fn.winwidth(0) > 100 end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " ", info = " " },
        colored = true,
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = { added = " ", modified = " ", removed = " " },
        cond = hide_in_width,
      }

      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { "neo-tree" },
          always_devide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch", diff, diagnostics },
          lualine_c = { filename },
          lualine_x = {
            { "lsp_status", cond = hide_in_width, click = function() vim.cmd ":LspInfo" end },
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
              click = function() vim.cmd ":Lazy" end,
            },
            { "encoding", cond = hide_in_width },
            { "fileformat", cond = hide_in_width },
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
        winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "lazy", "mason", "nvim-dap-ui", "oil", "quickfix", "trouble" },
      }
    end,
  },
}
