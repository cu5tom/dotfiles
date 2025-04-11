---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- NOTE: `opts = {}` is the same as calling `require("mason").setup({})`
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
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
            if vim.fn.has "nvim-0.11" == 1 then
              return client:supports_method(method, bufnr)
            else
              return client:supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- if client and client.server_capabilities.definitionProvider then
          --   map("gd", builtin.lsp_definitions, "Goto Definition")
          -- end
          -- if client and client.server_capabilities.declarationProvider then
          --   map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          -- end
          -- if client and client.server_capabilities.referencesProvider then
          --   map("gr", builtin.lsp_references, "Goto References")
          -- end
          -- if client and client.server_capabilities.implementationProvider then
          --   map("gI", builtin.lsp_implementations, "Goto Implementation")
          -- end
          -- map("<leader>cD", builtin.lsp_type_definitions, "Type Definition")
          -- map("<leader>cs", builtin.lsp_document_symbols, "Document Symbols")
          -- map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
          map("wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
          map("wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace List Folders")

          -- --if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          -- if client and client.server_capabilities.documentHighlightProvider then
          --   local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight", { clear = false })
          --
          --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI"}, {
          --     buffer = event.buf,
          --     callback = vim.lsp.buf.document_highlight,
          --     group = highlight_augroup
          --   })
          --
          --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI"}, {
          --     buffer = event.buf,
          --     callback = vim.lsp.buf.clear_references,
          --     group = highlight_augroup
          --   })
          --
          --   vim.api.nvim_create_autocmd("LspDetach", {
          --     group = vim.api.nvim_create_augroup("nvim-lsp-detach", { clear = true }),
          --     callback = function (event2)
          --       vim.lsp.buf.clear_references()
          --       vim.api.nvim_clear_autocmds({ group = "nvim-lsp-highlight", buffer = event2.buf })
          --     end
          --   })
          -- end

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

      -- local cmp = require("cmp")
      local cmp_lsp = require "cmp_nvim_lsp"

      local capabilities =
        vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      local servers = {
        ["angular-language-server"] = {},
        astro = {
          init_options = {
            typescript = {
              sdk = "/usr/local/lib/node_modules/typescript/lib"
            }
          },
        },
        cssls = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true
                }
              }
            }
          }
        },
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
        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = {
                version = "Lua 5.1" --[[ "LuaJIT" ]],
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              completion = {
                callSnippet = "Replace",
              },
              telemetry = { enable = false },
              diagnostics = {
                disable = { "missing-fields" },
                globals = { "after_each", "before_each", "describe", "it", "vim" },
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
                location = vim.fn.stdpath "data"
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
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
          settings = {
            typescript = {
              tsserver = {
                useSyntaxServer = false,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              telemetry = { enable = false },
            },
          },
        },
        twiggy_language_server = {
          filetypes = { "html", "njk" },
        },
        volar = {
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
          filetypes = { "vue" },
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = {
                  enabled = true,
                },
                functionLikeReturnTypes = {
                  enabled = true,
                },
                propertyDeclarationTypes = {
                  enabled = true,
                },
                parameterTypes = {
                  enabled = true,
                  suppressWhenArgumentMatchesName = true,
                },
                variableTypes = {
                  enabled = true,
                },
              },
              telemetry = { enable = false },
            },
          },
        },
        yamlls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "angular-language-server",
        "astro",
        "biome",
        "cssls",
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
        "volar",
      })
      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
      }

      require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
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
  -- {
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-neo-tree/neo-tree.nvim",
  --   },
  --   config = function() require("lsp-file-operations").setup() end,
  -- },
}
