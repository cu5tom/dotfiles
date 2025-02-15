---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require("plugins/telescope/multigrep").setup()
    end
  }
}
