return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("kanagawa").setup({
        overrides = function(colors)
          return {}
        end,
      })
    end,
  },
}
