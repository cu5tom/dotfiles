---@type LazySpec[]
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

      local opts = { silent = true, noremap = true }

      vim.keymap.set("n", "<leader>gs", function()
        neogit.open({ kind = "floating" })
      end, opts)
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
    },
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    }
  }
}
