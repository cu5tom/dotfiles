---@type LazySpec
return {
  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function ()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "alexandre-abrioux/blink-cmp-npm.nvim",
      "SergioRibera/cmp-dotenv",
      "mmolhoek/cmp-scss",
      "Fildo7525/pretty_hover",
      {
        "Jezda1337/nvim-html-css",
        dependencies = {
          "saghen/blink.cmp",
          "nvim-treesitter/nvim-treesitter",
        },
      },
      -- {
      --   "xzbdmw/colorful-menu.nvim",
      --   config = function()
      --     require("colorful-menu").setup {
      --       ls = {
      --         lua_ls = {
      --           arguments_hl = "@comment",
      --         },
      --         vtsls = {
      --           extra_info_hl = "@comment",
      --         },
      --       },
      --     }
      --   end,
      -- },
    },
    version = "1.*",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ["<C-Right>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<M-Up>"] = { "select_prev", "fallback" },
        ["<M-Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next" , "fallback_to_mappings" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      sources = {
        default = {
          "lsp",
          "snippets",
          "scss",
          "npm",
          "dotenv",
          "path",
          "buffer",
        },
        providers = {
          ["html-css"] = {
            name = "html-css",
            module = "blink.compat.source",
            opts = {
              enable_on = {
                "html",
                "htmldjango",
                "php",
                "vue",
              },
              style_sheets = {
                "./",
              },
            },
          },
          npm = {
            name = "npm",
            module = "blink-cmp-npm",
            async = true,
            ---@module "blink-cmp-npm"
            ---@type blink-cmp-npm.Options
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_versions = false,
            },
          },
          scss = {
            name = "scss",
            module = "blink.compat.source",
            opts = {
              folders = {
                "./",
              },
            },
          },
          dotenv = {
            name = "dotenv",
            module = "blink.compat.source",
            opts = {},
          },
        },
      },
      signature = {
        enabled = true,
        trigger = {
          enabled = false,
          show_on_keyword = false,
          blocked_retrigger_characters = {},
          blocked_trigger_characters = {},
          show_on_insert = false,
          show_on_trigger_character = true,
        },
        window = {
          border = "rounded",
          direction_priority = { "n", "s" },
          show_documentation = true,
          treesitter_highlighting = true,
        },
      },
      snippets = {
        preset = "luasnip",
        expand = function (snippet)
          vim.snippet.expand(snippet)
          -- require("luasnip").lsp_expand(snippet)
        end,
        active = function (filter)
          return vim.snippet.active(filter)
          -- if filter and filter.direction then
          --   return require("luasnip").jumpable(filter.direction)
          -- end
          -- return require("luasnip").in_snippet()
        end,
        jump = function (direction)
          vim.snippet.jump(direction)
          -- require("luasnip").jump(direction)
        end
      },
      term = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
        },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          local res = {}

          if type == "/" or type == "?" then
            res = { "buffer" }
          end

          if type == ":" or type == "@" then
            res = { "cmdline", "buffer" }
          end

          return res
        end,
      },
      completion = {
        list = {
          selection = {
            preselect = function ()
              return require("blink.cmp").snippet_active({ direction = 1 })
            end,
            auto_insert = false,
          },
        },
        keyword = { range = "full" },
        trigger = {
          show_in_snippet = true,
          show_on_trigger_character = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 100,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            direction_priority = {
              menu_north = { "e", "w", "n", "s" },
              menu_south = { "e", "w", "s", "n" },
            },
          },
          draw = function (opts)
            if opts.item and opts.item.documentation then
              local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
              opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
          end
        },
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = "rounded",
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_id" },
            },
            -- components = {
            --   label = {
            --     text = function(ctx)
            --       return require("colorful-menu").blink_components_text(ctx)
            --     end,
            --     highlight = function(ctx)
            --       return require("colorful-menu").blink_components_highlight(ctx)
            --     end,
            --   },
            -- },
          },
        },
      },
      fuzzy = {
        sorts = {
          "exact",
          "score",
          "sort_text"
        },
        implementation = "prefer_rust_with_warning",
      },
    },
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = { "InsertEnter" },
  --   lazy = false,
  --   priority = 100,
  --   dependencies = {
  --     { "hrsh7th/cmp-buffer", lazy = true },
  --     { "hrsh7th/cmp-cmdline", lazy = true },
  --     { "hrsh7th/cmp-path", lazy = true },
  --     { "hrsh7th/cmp-nvim-lsp", lazy = true },
  --     { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
  --     { "hrsh7th/cmp-nvim-lua", lazy = true },
  --     {
  --       "L3MON4D3/LuaSnip",
  --       build = "make install_jsregexp",
  --     },
  --     { "onsails/lspkind.nvim" },
  --     { "saadparwaiz1/cmp_luasnip" },
  --     { "rafamadriz/friendly-snippets" },
  --     {
  --       "David-Kunz/cmp-npm",
  --       dependencies = { "nvim-lua/plenary.nvim" },
  --       lazy = false,
  --       ft = "json",
  --       config = function()
  --         require("cmp-npm").setup({})
  --       end
  --     },
  --     { "roginfarrer/cmp-css-variables" }
  --   },
  --   opts = {},
  --   config = function()
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --
  --     local lspkind = require "lspkind"
  --     lspkind.init {}
  --
  --     local luasnip = require "luasnip"
  --     luasnip.config.set_config {
  --       history = false,
  --       updateevents = "TextChanged, TextChangedI",
  --     }
  --
  --     local cmp = require "cmp"
  --     cmp.setup {
  --       experimental = {
  --         ghost_text = true
  --       },
  --       completion = { completeopt = "menu,menuone,noselect,preview" },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       formatting = {
  --         fields = {
  --           cmp.ItemField.Abbr,
  --           cmp.ItemField.Kind,
  --           cmp.ItemField.Menu,
  --         },
  --         format = lspkind.cmp_format {
  --           with_text = false,
  --           menu = {
  --             buffer = "[buf]",
  --             luasnip = "[snip]",
  --             nvim_lsp = "[lsp]",
  --             nvim_lsp_signature_help = "[sig]",
  --             nvim_lua = "[api]",
  --             npm = "[npm]",
  --             path = "[path]",
  --           },
  --           mode = "symbol_text",
  --           -- maxwidth = 50,
  --           ellipsis_char = "...",
  --           show_labelDetails = true,
  --           before = function (entry, vim_item)
  --             local types = require("cmp.types")
  --             local str = require("cmp.utils.str")
  --
  --             local word = entry:get_insert_text()
  --             if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
  --               word = str.get_word(word)
  --             end
  --
  --             word = str.oneline(word)
  --             if entry.completion_item.insertTextFormat then
  --               word = word .. "~"
  --             end
  --
  --             vim_item.abbr = word
  --             return vim_item
  --           end
  --         },
  --       },
  --       sorting = {
  --         priority_weight = 2,
  --         comparators = {
  --           cmp.config.compare.exact,
  --           cmp.config.compare.offset,
  --           cmp.config.compare.score,
  --           cmp.config.compare.recently_used,
  --           cmp.config.compare.locality,
  --           cmp.config.compare.kind,
  --           cmp.config.compare.sort_text,
  --           cmp.config.compare.length,
  --           cmp.config.compare.order,
  --         }
  --       },
  --       sources = {
  --         { name = "nvim_lsp" },
  --         { name = "nvim_lua" },
  --         { name = "luasnip" },
  --         -- { name = "nvim_lsp_signature_help" },
  --         { name = "path" },
  --         -- { name = "buffer", keyword_length = 5, max_item_count = 5 },
  --         { name = "css-variables" },
  --         { name = "npm", keyword_length = 3 },
  --       },
  --       mapping = {
  --         ["<C-c>"] = cmp.mapping.complete {},
  --         ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
  --         ["<M-Down>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<M-Up>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       },
  --       snippet = {
  --         expand = function(args) require("luasnip").lsp_expand(args.body) end,
  --       },
  --     }
  --
  --     cmp.setup.filetype({ "sql" }, {
  --       sources = {
  --         { name = "vim-dadbod-completion" },
  --         { name = "buffer" },
  --       },
  --     })
  --
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --
  --     vim.keymap.set({ "i", "s" }, "<c-k>", function()
  --       if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
  --     end, { silent = true })
  --
  --     vim.keymap.set({ "i", "s" }, "<c-j", function()
  --       if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
  --     end, { silent = true })
  --   end,
  -- },
}
