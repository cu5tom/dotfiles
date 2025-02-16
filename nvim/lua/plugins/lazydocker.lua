return {
  {
    "mgierada/lazydocker.nvim",
    keys = {
      {
        "<leader>T",
        function ()
          require("lazydocker").open()
        end,
        desc = "Open Lazydocker"
      }
    }
  }
}
