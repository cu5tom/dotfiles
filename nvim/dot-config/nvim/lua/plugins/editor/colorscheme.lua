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
            constants = "bold",
            -- keywords = "bold",
            types = "italic,bold",
          },
          -- transparent = true,
        },
        palettes = {
          nordfox = {
            comment = "#71839b",
          }
        },
        specs = {
          nordfox = {
            syntax = {
              builtin = "orange.bright",
              conditional = "magenta.bright",
              keyword = "magenta.bright"
            }
          }
        }
      })

      vim.cmd.colorscheme("nordfox")
    end
  }
}
