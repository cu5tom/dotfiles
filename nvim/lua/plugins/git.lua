return {
  "FabijanZulj/blame.nvim",
  config = function ()
    local virtual_view = require "blame.views.virtual_view"
    require("blame").setup {
      views = {
        default = virtual_view
      }
    }
  end,
}
