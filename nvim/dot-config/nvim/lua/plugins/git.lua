return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim"
    },
    config = function ()
      local neogit = require("neogit")
      neogit.setup({})

      vim.keymap.set("n", "<leader>gg", function()
        neogit.open({ kind = "floating" })
      end, { desc = "Neogit", silent = true, noremap = true })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      sign_priority = 50,
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end)

        -- map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        -- map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk inline" })

        map("n", "<leader>gB", function() gitsigns.blame_line { full = true } end, { desc = "Blame Line" })

        map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
        map("n", "<leader>gD", function() gitsigns.diffthis "~" end, { desc = "Diff this ~" })

        map("n", "<leader>gQ", function() gitsigns.setqflist "all" end, { desc = "Set QFList all" })
        map("n", "<leader>gq", gitsigns.setqflist, { desc = "Set QFList" })

        map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
        -- map("n", "<leader>htw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })

        -- map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
      end,
    },
  },
}
