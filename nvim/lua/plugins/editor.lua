---@type LazySpec
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    config = function()
      local ok, harpoon = pcall(require, "harpoon")
      if not ok then
        return
      end

      harpoon:setup({
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
          enter_on_sendcmd = false,
          tmux_autoclose_windows = false,
          excluded_filetypes = { "harpoon" },
          mark_branch = true,
          tabline = false,
        },
      })

      local function normalize_list(list)
        local normalized = {}
        for _, v in pairs(list) do
          if v ~= nil then
            table.insert(normalized, v)
          end
        end

        return normalized
      end

      local function harpoon_picker()
        local items = {}
        local list = normalize_list(harpoon:list().items)

        for _, item in ipairs(list) do
          table.insert(items, {
            file = item.value,
            text = item.value,
          })
        end

        return items
      end

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>fh", function()
        Snacks.picker({
          title = "Harpoon",
          finder = harpoon_picker,
          win = {
            input = {
              keys = {
                ["dd"] = { "harpoon_delete", mode = { "n", "x" } }
              },
            },
            list = {
              keys = {
                ["dd"] = { "harpoon_delete", mode = { "n", "x" } }
              },
            }
          },
          actions = {
            harpoon_delete = function(picker, item)
              local to_be_removed = item or picker:selected()
              harpoon:list():remove({ value = to_be_removed.text })
              harpoon:list().items = normalize_list(harpoon:list().items)
              picker:find({ refresh = true })
            end
          },
        })
      end, { desc = "Harpoon" })
    end
  },
  {
    "mbbill/undotree",
    opts = {},
    config = function() vim.g.undotree_WindowLayout = 4 end,
    keys = {
      { "<leader>uu", vim.cmd.UndotreeToggle, desc = "Undotree Toggle" },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        "*",
        css = { rgb_fn = true },
        html = { names = false },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    },
    -- config = function()
    --   local todo_comments = require "todo-comments"
    --
    --   vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next todo comment" })
    --   vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" })
    --
    --   todo_comments.setup()
    -- end,
  },
  {
    "RRethy/vim-illuminate",
  },
  -- {
  --   "willothy/nvim-cokeline",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "stevearc/resession.nvim",
  --   },
  --   config = function()
  --     local get_hex = require("cokeline.hlgroups").get_hl_attr
  --     local yellow = vim.g.terminal_color_3
  --
  --     require("cokeline").setup {
  --       default_hl = {
  --         fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
  --         bg = function() return get_hex("ColorColumn", "bg") end,
  --       },
  --       sidebar = {
  --         filetype = { "NvimTree", "neo-tree" },
  --         components = {
  --           {
  --             text = function(buf) return buf.filetype end,
  --             fg = yellow,
  --             bg = function() return get_hex("NvimTreeNormal", "bg") end,
  --             bold = true,
  --           },
  --         },
  --       },
  --       components = {
  --         {
  --           text = function(buf) return (buf.index ~= 1) and "|" or "" end,
  --         },
  --         {
  --           text = " ",
  --         },
  --         {
  --           text = function(buf) return buf.devicon.icon end,
  --           fg = function(buf) return buf.devicon.color end,
  --         },
  --         {
  --           text = " ",
  --         },
  --         {
  --           text = function(buf) return buf.filename .. " " end,
  --           bold = function(buf) return buf.is_focused end,
  --         },
  --         {
  --           text = "x",
  --           on_click = function(_, _, _, _, buf) buf:delete() end,
  --         },
  --         {
  --           text = " ",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- local theme = {
      --   fill = "TablineFill",
      --   head = "Tabline",
      --   current_tab = "TablineSel",
      --   tab = "Tabline",
      --   win = "Tabline",
      --   tail = "Tabline",
      -- }

      require("tabby").setup {
        preset = "active_wins_at_tail",
        -- options = {
        --   theme = theme,
        --   nerdfont = true,
        --   lualine_theme = nil,
        --   tab_name = {
        --     name_fallback = function(tabid) return tabid end,
        --   },
        --   buf_name = {
        --     mode = "tail", -- "'unique'|'relative'|'tail'|'shorten'"
        --   },
        -- },
      }

      vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { desc = "New tab", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tc", ":$tabclose<CR>", { desc = "Close tab", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>to", ":$tabonly<CR>", { desc = "Only tab", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tn", ":$tabn<CR>", { desc = "Next tab", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tp", ":$tabp<CR>", { desc = "Previous tab", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tmp", ":$-tabmove<CR>", { desc = "Move tab to the left", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tmn", ":$+tabmove<CR>", { desc = "New tab", noremap = true })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lazy_status = require "lazy.status"
      -- local colors = {}

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

      -- local lsp_clients = {
      --   "lsp_clients",
      --   fmt = function()
      --     local bufnr = vim.api.nvim_get_current_buf()
      --     local clients = vim.lsp.buf_get_clients(bufnr)
      --     if next(clients) == nil then return "" end
      --
      --     local c = {}
      --     for _, client in pairs(clients) do
      --       table.insert(c, client.name)
      --     end
      --     return " " .. table.concat(c, ", ")
      --   end,
      --   update_in_insert = false,
      --   always_visible = false,
      --   cond = hide_in_width,
      -- }

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
            { "lsp_status", click = function() vim.cmd ":LspInfo" end },
            -- lsp_clients,
            -- diagnostics,
            -- diff,
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
              click = function() vim.cmd ":Lazy" end,
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
