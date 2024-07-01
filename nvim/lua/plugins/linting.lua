return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      event = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        -- javascript = { "biome" },
        -- typescript = { "biome" },
      },
    },
  },
}
