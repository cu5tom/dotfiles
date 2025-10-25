---@module 'snacks'
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { link = "@diff.plus" })
      vim.g.snacks_animate = false
    end,
    ---@type snacks.Config
    opts = {
      bigfile = {},
      dim = {},
      explorer = {
        replace_netrw = true,
      },
      indent = {},
      input = {},
      lazygit = {},
      picker = {
        -- layout = { preset = "ivy" },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            exclude = {
              "**/.git/*",
              "**/.jj/*",
              -- "**/node_modules/*",
              "**/.yarn/cache/*",
              "**/.yarn/releases/*",
              "**/.pnpm-store/*",
            },
            include = {
              "**/.env",
              "**/.npmrc",
            },
          },
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              "**/.git/*",
              "**/.jj/*",
              -- "**/node_modules/*",
              "**/.yarn/cache/*",
              "**/.yarn/releases/*",
              "**/.pnpm-store/*",
            },
            include = {
              "**/.env",
              "**/.npmrc",
            },
          },
        },
        win = {
          input = {
            keys = {
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      notifier = {},
      scope = {},
      scratch = {},
      statuscolumn = {},
    },
    keys = {
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      -- Pickers & Explorer
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- Find
      {
        "<leader>fc",
        function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end,
        desc = "Find Config Files",
      },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent { filter = { cwd = true } } end, desc = "Recent" },
      { "<leader>fs", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      -- Buffers
      { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete Buffer" },
      { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all Buffers" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other Buffers" },
      -- Git
      -- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word" },
      -- Search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "<leader>T", function() Snacks.terminal.toggle() end },
    },
  },
}
