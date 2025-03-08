local which_key = require "which-key"

return {
  {
    "imNel/monorepo.nvim",
    config = function()
      require("monorepo").setup {}

      which_key.add {
        "<leader>M",
        mode = "n",
        function() require("telescope").extensions.monorepo.monorepo() end,
        desc = "Find projects",
      }
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
