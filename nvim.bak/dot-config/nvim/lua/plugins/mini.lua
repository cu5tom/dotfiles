---@type LazySpec
return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      { 
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    version = false,
    config = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter;
      require("mini.ai").setup({
        use_nvim_treesitter = true,
        custom_textobjects = {
          F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
          o = spec_treesitter({ 
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
          ["="] = spec_treesitter({
            i = "@assignment.lhs",
            a = "@assignment.rhs",
          }),
          A = spec_treesitter({
            i = "@attribute.inner",
            a = "@attribute.outer",
          })
        }
      })

      require("mini.bracketed").setup()

      require("mini.cursorword").setup()
      -- require("mini.completion").setup()

      -- require("mini.files").setup()

      -- require("mini.icons").setup()

      require("mini.move").setup()

      require("mini.operators").setup()

      require("mini.pairs").setup()

      -- require("mini.snippets").setup()

      require("mini.surround").setup()
    end,
  },
}
