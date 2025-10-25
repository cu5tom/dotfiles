---@type LazySpec
return {
  ---@module "tiny-inline-diagnostic"
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup {
        preset = "simple",
        options = {
          show_source = {
            enabled = true,
            if_many = true,
          },
        },
      }
      vim.diagnostic.config { virtual_text = false }
    end,
  },
}
