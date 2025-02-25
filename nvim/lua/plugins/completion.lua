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
        completion = { completeopt = "menu,menuone,noselect" },
        formatting = {
          fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu
          },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = {
              menu = 50,
              abbr = 50,
            },
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function (entry, vim_item)
              local types = require("cmp.types")
              local str = require("cmp.utils.str")

              local word = entry:get_insert_text()
              if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                word = vim.lsp.util.parse_snippet(word)
              end

              word = str.oneline(word)
              if entry.completion_item.insertTextFormat then
                word = word .. "~"
              end

              vim_item.abbr = word
              return vim_item
            end
          })
        },
        sources = {
          -- { name = "buffer" },
          { name = "buffer", keyword_length = 5, max_item_count = 5 },
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
            {"i" ,"s"}
          ),
          ["<C-k>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end, {"i" ,"s" }),
          ["<Tab>"] = cmp.mapping(
            function (fallback)
              if ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
              else
                fallback()
              end
            end, {"i", "s" }),
          ["<S-Tab>"] = cmp.mapping(
            function (fallback)
              if ls.locally_jumpable(-1) then
                ls.jump(-1)
              else
                fallback()
              end
            end, {"i", "s" })
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        }
      })

      require("cmp").setup.cmdline(":", {
	      sources = {
		      { name = "cmdline", keyword_length = 2 },
	      },
      })

      vim.keymap.set({ "i", "s" }, "<c-k>", function ()
        if ls.expand_or_locally_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-j", function ()
        if ls.locally_jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end
  }
}
