---@type LazySpec
return {
  {
    "NickvanDyke/opencode.nvim",
    event = "VeryLazy",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
     config = function()
       vim.g.opencode_opts = {
         prompts = {
           -- Neovim/Lua specific prompts
           ["lua_debug"] = "Debug this Lua code for Neovim. Check for common issues like nil checks, proper API usage, and Neovim-specific patterns: @this",
           ["lua_optimize"] = "Optimize this Lua/Neovim code for performance and readability. Consider lazy loading, caching, and Neovim best practices: @this",
           ["lua_document"] = "Add comprehensive documentation to this Lua/Neovim code following EmmyLua annotation standards: @this",
           ["plugin_review"] = "Review this Neovim plugin code for best practices, error handling, and compatibility: @this",

           -- Dotfiles and configuration
           ["dotfiles_audit"] = "Audit these dotfiles for security issues, best practices, and potential improvements: @this",
           ["config_optimize"] = "Optimize this configuration for performance, maintainability, and cross-platform compatibility: @this",
           ["shell_improve"] = "Improve this shell script for robustness, error handling, and POSIX compliance: @this",

           -- Development workflow
           ["git_workflow"] = "Analyze this git workflow and suggest improvements for branching strategy, commit messages, and collaboration: @this",
           ["testing_strategy"] = "Design a testing strategy for this codebase considering the existing setup and constraints: @this",
           ["ci_cd_review"] = "Review this CI/CD configuration for security, efficiency, and best practices: @this",

           -- Code analysis
           ["security_audit"] = "Perform a security audit on this code, checking for vulnerabilities, unsafe patterns, and best practices: @this",
           ["performance_profile"] = "Analyze this code for performance bottlenecks and suggest optimizations: @this",
           ["accessibility_check"] = "Review this code/interface for accessibility compliance and inclusive design: @this",
         }
       }

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

         -- Custom prompts for Neovim/Lua development
         { mode = { "n", "x" }, lhs = "<leader>old", rhs = function() opencode.prompt "lua_debug" end, desc = "Debug Lua code" },
         { mode = { "n", "x" }, lhs = "<leader>olo", rhs = function() opencode.prompt "lua_optimize" end, desc = "Optimize Lua code" },
         { mode = { "n", "x" }, lhs = "<leader>olp", rhs = function() opencode.prompt "plugin_review" end, desc = "Review plugin code" },

         -- Custom prompts for dotfiles/config
         { mode = { "n", "x" }, lhs = "<leader>oda", rhs = function() opencode.prompt "dotfiles_audit" end, desc = "Audit dotfiles" },
         { mode = { "n", "x" }, lhs = "<leader>oco", rhs = function() opencode.prompt "config_optimize" end, desc = "Optimize config" },
         { mode = { "n", "x" }, lhs = "<leader>osh", rhs = function() opencode.prompt "shell_improve" end, desc = "Improve shell script" },

         -- Development workflow prompts
         { mode = { "n", "x" }, lhs = "<leader>ogw", rhs = function() opencode.prompt "git_workflow" end, desc = "Analyze git workflow" },
         { mode = { "n", "x" }, lhs = "<leader>ots", rhs = function() opencode.prompt "testing_strategy" end, desc = "Design testing strategy" },

         -- Code analysis prompts
         { mode = { "n", "x" }, lhs = "<leader>osa", rhs = function() opencode.prompt "security_audit" end, desc = "Security audit" },
         { mode = { "n", "x" }, lhs = "<leader>opp", rhs = function() opencode.prompt "performance_profile" end, desc = "Performance analysis" },

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
