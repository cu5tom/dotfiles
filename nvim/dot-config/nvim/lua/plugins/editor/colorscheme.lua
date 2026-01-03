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
        palettes = {
          nordfox = {
            comment = "#71839b",
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
