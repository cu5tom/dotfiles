---@type LazySpec
return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.basics").setup()

      require("mini.diff").setup()

      -- require("mini.git").setup()

      require("mini.icons").setup()

      require("mini.move").setup()

      require("mini.notify").setup()

      require("mini.pairs").setup()

      require("mini.statusline").setup({
        use_icons = true
      })

      require("mini.surround").setup()
    end
  }
}
