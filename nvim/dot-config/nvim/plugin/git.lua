local loader = require("mini-loader")

vim.pack.add({
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/folke/snacks.nvim",
})

local neogit = require("neogit")
neogit.setup({
  integrations = {
    snacks = true
  }
})

vim.keymap.set("n", "<leader>gg", function()
	neogit.open({ kind = "split" })
end, { silent = true, noremap = true, desc = "Neogit" })

local load_gitsigns = function ()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

  local gitsigns = require("gitsigns")

  gitsigns.setup({
    current_line_blame = true,
    sign_priority = 50,
    on_attach = function(bufnr)
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

      map("n", "<leader>hp", function ()
        gitsigns.preview_hunk()
      end)
    end,
  })
end

loader.on_event("BufReadPre", load_gitsigns)
loader.on_event("BufNewFile", load_gitsigns)
