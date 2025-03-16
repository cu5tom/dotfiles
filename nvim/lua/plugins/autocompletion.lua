---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    lazy = false,
    priority = 100,
    dependencies = {
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      { "onsails/lspkind.nvim" },
      { "saadparwaiz1/cmp_luasnip" },
      { "rafamadriz/friendly-snippets" },
      {
        "David-Kunz/cmp-npm",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "json",
        config = function()
          require("cmp-npm").setup({})
        end
      },
    },
    opts = {},
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      local lspkind = require "lspkind"
      lspkind.init {}

      local luasnip = require "luasnip"
      luasnip.config.set_config {
        history = false,
        updateevents = "TextChanged, TextChangedI",
      }

      local cmp = require "cmp"
      cmp.setup {
        completion = { completeopt = "menu,menuone,noselect,preview" },
        formatting = {
          fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
          },
          format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            -- before = function (entry, vim_item)
            --   local types = require("cmp.types")
            --   local str = require("cmp.utils.str")
            --
            --   local word = entry:get_insert_text()
            --   if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
            --     word = str.get_word(word)
            --   end
            --
            --   word = str.oneline(word)
            --   if entry.completion_item.insertTextFormat then
            --     word = word .. "~"
            --   end
            --
            --   vim_item.abbr = word
            --   return vim_item
            -- end
          },
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "npm", keyword_length = 4 },
          -- { name = "buffer", keyword_length = 5, max_item_count = 5 },
          { name = "path" },
        },
        mapping = {
          ["<C-c>"] = cmp.mapping.complete {},
          ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
          ["<M-Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<M-Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
      }

      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path " },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-j", function()
        if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
      end, { silent = true })
    end,
  },
}
