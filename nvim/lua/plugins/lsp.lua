---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- NOTE: `opts = {}` is the same as calling `require("mason").setup({})`
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "/usr/share/awesome/lib/", words = { "awesome" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
    },
    config = function()
      -- local builtin = require "telescope.builtin"

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer
          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>cs", vim.lsp.buf.document_symbol, "Symbols")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
          map("wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
          map("wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace List Folders")

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map(
              "<leader>ch",
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              "Toggle Inlay Hints"
            )
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }

            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local cmp_lsp = require "cmp_nvim_lsp"

      local capabilities =
        vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      local enabled_servers = {
        ["angular-language-server"] = {},
        astro = {
          init_options = {
            typescript = {
              sdk = "/usr/local/lib/node_modules/typescript/lib"
            }
          },
        },
        ast_grep = {},
        emmet_ls = {},
        eslint_d = {},
        html = {
          filetypes = { "html", "njk" },
        },
        jsonls = {
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package.json",
                },
              },
            },
          },
        },
        -- TODO: Check lua lsp config
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"--[[ "Lua 5.1" ]],
              },
              telemetry = { enable = false },
              diagnostics = {
                disable = { "missing-fields" },
                globals = { "after_each", "before_each", "describe", "it", "require", "vim" },
              },
            },
          },
        },
        marksman = {},
        mdx_analyzer = {},
        phpactor = {},
        somesass_ls = {},
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
          },
        },
        twiggy_language_server = {
          filetypes = { "html", "njk" },
        },
        vue_ls = {},
        yamlls = {},
      }

      local disabled_servers = {}

      for server_name, server in pairs(enabled_servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "angular-language-server",
        "astro",
        "biome",
        "djlint",
        "eslint_d",
        "emmet_ls",
        "goimports",
        "gomodifytags",
        "gotests",
        "html",
        "jsonls",
        "phpactor",
        "php-cs-fixer",
        "prettierd",
        "somesass_ls",
        "stylua",
        "ts_ls",
        "vue_ls",
      })
      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
      }

      require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_enable= {
          exclude = disabled_servers
        },
        automatic_installation = false,
      }


    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: Symbols" },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Trouble: LSP Definitions / references / ...",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix List" },
    },
  },
}
