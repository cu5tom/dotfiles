return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec", "disable.ft", "disable.bt" },
    opts = {
      delay = 0,
      icons = {
        group = vim.g.icons_enabled ~= false and "" or "+",
        rules = false,
        separator = "-",
      },
      plugins = {
        marks = true,
        registers = true,
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z= true,
          g= true,
        }
      }
    },
    config = function()
      local wk = require("which-key")

      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find/Files" },
        { "<leader>g", group = "Git", mode = { "n", "v" } },
        { "<leader>s", group = "Search"},
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Diagnostics" },
      })

      local utils = require("core.utils")
      local nmap_leader = utils.nmap_leader

      nmap_leader("bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
      nmap_leader("bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")

      nmap_leader("ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
      nmap_leader("cd", "<Cmd>Pick lsp scope='definition'<CR>", "Definition")
      nmap_leader("ci", "<Cmd>Pick lsp scope='implementation'<CR>", "Implementation")
      nmap_leader("cr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
      nmap_leader("cR", "<Cmd>Pick lsp scope='references'<CR>", "References")
      nmap_leader("ct", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")

      nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")

      nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
      nmap_leader("fk", "<Cmd>Pick keymaps<CR>", "Keymaps")

      nmap_leader("sg", "<Cmd>Pick grep_live<CR>", "Grep live")
      nmap_leader("sG", "<Cmd>Pick grep pattern='<cword>'<CR>", "Grep current word")
      nmap_leader("sr", "<Cmd>Pick resume<CR>", "Resume")
      nmap_leader("sh", "<Cmd>Pick help<CR>", "Help")

      nmap_leader("xd", "<Cmd>Pick diagnostic scope='all'<CR>", "Diagnostic workspace")
      nmap_leader("xD", "<Cmd>Pick diagnostic scope='current'<CR>", "Diagnostic buffer")
    end
  },
}

