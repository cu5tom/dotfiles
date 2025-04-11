---@type LazySpec
return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup {}

      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then Snacks.rename.on_rename_file(event.data.from, event.data.to) end
        end,
      })
    end,
    keys = {
      { "-", "<cmd>Oil --float<cr>", desc = "Oil" },
    },
  },
}
