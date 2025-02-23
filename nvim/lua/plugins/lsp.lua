---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0
            }
          }
        }
      }
    },
    config = function()
      local builtin = require("telescope.builtin")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function (keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", builtin.lsp_definitions, "Goto Definition")
          map("gr", builtin.lsp_references, "Goto References")
          map("gI", builtin.lsp_implementations, "Goto Implementation")
          map("<leader>D", builtin.lsp_type_definitions, "Type Definition")
          map("<leader>cs", builtin.lsp_document_symbols, "Document Symbols")
          map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
          map("wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
          map("wl", function ()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "Workspace List Folders")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI"}, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI"}, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        astro = {},
        cssls = {},
        emmet_ls = {},
        html = {
          filetypes = { "html", "njk" }
        },
        jinja_lsp = {},
        jsonls = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file('', true))
                }
              },
              completion = {
                callSnippet = "Replace",
              },
              telemetry = { enable = false },
              diagnostics = {
                disable = { "missing-fields" }
              }
            }
          }
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
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"},
              }
            }
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        },
        volar = {},
        yamlls = {}
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua"
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed
      })

      require("mason-lspconfig").setup({
        handlers = {
          function (server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end
        }
      })
    end
  },
}
