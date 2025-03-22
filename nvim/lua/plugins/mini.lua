---@type LazySpec
return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- local spec_treesitter = require("mini.ai").gen_spec.treesitter
      -- require("mini.ai").setup {
      --   custom_textobjects = {
      --     -- ['"'] = { '"().-()"' },
      --     F = spec_treesitter { a = "@function.outer", i = "@function.inner" },
      --     o = spec_treesitter {
      --       a = { "@conditional.outer", "@loop.outer" },
      --       i = { "@conditional.inner", "@loop.inner" },
      --     },
      --   },
      --   n_lines = 500,
      -- }
      -- require("mini.basics").setup()

      -- require("mini.diff").setup()

      -- require("mini.git").setup()

      -- require("mini.icons").setup()

      require("mini.move").setup()

      -- require("mini.notify").setup()

      -- require("mini.pairs").setup()

      -- require("mini.statusline").setup({
      --   use_icons = true
      -- })
      --
      require("mini.surround").setup()
    end,
  },
}
