return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            types = "italic,bold",
          }
        },
        specs = {
          nordfox = {
            syntax = {
              builtin = "orange",
              conditional = "magenta.bright"
            }
          }
        }
      })

      vim.cmd.colorscheme("nordfox")
    end
  }
}
