---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      { "onsails/lspkind.nvim" },
      { "saadparwaiz1/cmp_luasnip" }
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0
      })
    end,
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({})

      local ls = require("luasnip")
      ls.config.set_config({
        history = false,
        updateevents = "TextChanged, TextChangedI"
      })

      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffr" },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true
            }),
            { "i", "c" }
          )
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        }
      })

      vim.keymap.set({ "i", "s" }, "<c-k>", function ()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-j", function ()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end
  }
}
