---@type LazySpec
return {
  {
    "NickvanDyke/opencode.nvim",
    event = "VeryLazy",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
    },
    config = function()
      vim.g.opencode_opts = {}

      vim.o.autoread = true

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      local opencode = require "opencode"

      local keymaps = {
        -- Core functionality
        {
          mode = { "n", "x" },
          lhs = "<leader>oa",
          rhs = function() opencode.ask("@this: ", { submit = true }) end,
          desc = "Ask about this",
        },
        { mode = { "n", "x" }, lhs = "<leader>os", rhs = function() opencode.select() end, desc = "Select prompt" },
        { mode = { "n", "x" }, lhs = "<leader>o+", rhs = function() opencode.prompt "@this" end, desc = "Add this" },

        -- Session management
        { mode = "n", lhs = "<leader>ot", rhs = function() opencode.toggle() end, desc = "Toggle embedded" },
        { mode = "n", lhs = "<leader>oc", rhs = function() opencode.command() end, desc = "Select command" },
        { mode = "n", lhs = "<leader>on", rhs = function() opencode.command "session_new" end, desc = "New session" },
        {
          mode = "n",
          lhs = "<leader>oi",
          rhs = function() opencode.command "session_interrupt" end,
          desc = "Interrupt session",
        },

        -- Agent and navigation
        {
          mode = "n",
          lhs = "<leader>oA",
          rhs = function() opencode.command "agent_cycle" end,
          desc = "Cycle selected agent",
        },
        {
          mode = "n",
          lhs = "<S-C-u>",
          rhs = function() opencode.command "messages_half_page_up" end,
          desc = "Messages half page up",
        },
        {
          mode = "n",
          lhs = "<S-C-d>",
          rhs = function() opencode.command "messages_half_page_down" end,
          desc = "Messages half page down",
        },
      }

      map("n", "<leader>o", "", { desc = "OpenCode" })

      for _, km in ipairs(keymaps) do
        map(km.mode, km.lhs, km.rhs, { desc = km.desc })
      end
    end,
  },
}
