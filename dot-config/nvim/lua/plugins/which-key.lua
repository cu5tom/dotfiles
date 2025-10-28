---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec", "disable.ft", "disable.bt" },
    opts = {
      delay = 0,
      icons = {
        group = vim.g.icons_enabled ~= false and "" or "+",
        rules = false,
        separator = "-",
      },
      spec = {
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git", mode = { "n", "v" } },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Tabs" },
        { "<leader>T", group = "Terminal" },
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Trouble" },
      },
    },
  },
}
