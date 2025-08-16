return {
  {
    "imNel/monorepo.nvim",
    config = function()
      require("monorepo").setup {}
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
