---@type LazySpec[]
return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "LazyGitConfig" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGitCurrentFile" },
      { "<leader>gF", "<cmd>LazyGitFilter<cr>", desc = "LazyGitFilter" },
      { "<leader>gB", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGitFilterCurrentFile" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "Jump to next git change" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Jump to previous git change" })

        -- Actions
        -- visual mode
        map(
          "v",
          "<leader>gs",
          function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "Stage hunk" }
        )

        map(
          "v",
          "<leader>gr",
          function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "Reset hunk" }
        )

        -- normal mode

        map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>gu", gitsigns.stage_hunk, { desc = "Unstage hunk" })
        map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gb", gitsigns.blame_line, { desc = "Blame line" })
        map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff against index" })
        map("n", "<leader>gD", function() gitsigns.diffthis "@" end, { desc = "Diff against last commit" })
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle show line blame" })
        map("n", "<leader>gtd", gitsigns.preview_hunk_inline, { desc = "Toggle show deleted" })
      end,
    },
  },
}
