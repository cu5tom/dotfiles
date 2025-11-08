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
      bigfile = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
    }
  },
}
