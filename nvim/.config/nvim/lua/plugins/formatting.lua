return {
  "tpope/vim-sleuth",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup {}
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>bf",
        function() require("conform").format { async = true, lsp_format = "fallback" } end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        astro = { "biome" },
        css = { "biome" },
        javascript = { "biome" },
        lua = { "stylua" },
        scss = { "biome" },
        sass = { "biome" },
        typescript = { "biome" },
        vue = { "biome" }
      },
    },
  },
}
