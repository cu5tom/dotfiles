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
      "saghen/blink.cmp",
    },
    config = function()
      local lspUtil = require "lspconfig.util"
      -- local builtin = require "telescope.builtin"

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer
          local function client_supports_method(client, method, bufnr) return client:supports_method(method, bufnr) end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("S", vim.lsp.buf.signature_help, "Signature help")
          map("<leader>cs", vim.lsp.buf.document_symbol, "Symbols")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rs", ":LspRestart<CR>", "Restart Lsp")
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

          -- if client and client.name == "vtsls" then
          --   vim.notify("Typescript LSP started with incremental checking enabled", vim.log.levels.INFO)
          -- end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        update_in_insert = false,
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
          spacing = 4,
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

      local ensure_installed_dependend_servers = {
        "vue_ls"
      }
      ---@class LspServersConfig
      ---@field mason table<string, vim.lsp.Config>
      ---@field others table<string, vim.lsp.Config>
      local servers = {
        mason = {
          angularls = {
            root_dir = lspUtil.root_pattern "angular.json",
            root_markers = { "angular.json", "nx.json" },
          },
          ast_grep = {},
          biome = {},
          emmet_ls = {},
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
                  {
                    fileMatch = { "tsconfig.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                  },
                },
              },
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT" --[[ "Lua 5.1" ]],
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
          oxlint = {},
          phpactor = {},
          somesass_ls = {},
          stylua = {},
          ts_ls = {
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.stdpath "data"
                    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { "vue" },
                },
              },
            },
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
            settings = {
              typescript = {
                tsserver = {
                  useSyntaxServer = false,
                  experimental = {
                    enableProjectDiagnostics = true
                  }
                },
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                }
              }
            }
          },
          twiggy_language_server = {
            filetypes = { "html", "njk" },
          },
        },
        others = {},
      }

      local ensure_installed = vim.tbl_keys(servers.mason or {})
      vim.list_extend(ensure_installed, ensure_installed_dependend_servers)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      for server, config in pairs(vim.tbl_extend("keep", servers.mason, servers.others)) do
        if not vim.tbl_isempty(config) then
          config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
          config.capabilities.textDocument = config.capabilities.textDocument or {}
          config.capabilities.textDocument.publishDiagnostics = {
            relatedInformation = true,
            versionSupport = true,
            tagSupport = { 1, 2 },
          }
          vim.lsp.config(server, config)
        end
      end

      require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_enable = true,
      }

      if not vim.tbl_isempty(servers.others) then vim.lsp.enable(vim.tbl_keys(servers.others)) end
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
  {
    "antosha417/nvim-lsp-file-operations",
    config = {},
  },
}
