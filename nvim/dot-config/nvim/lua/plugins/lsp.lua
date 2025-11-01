---@type LazySpec
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local lspUtil = require("lspconfig.util")

			vim.diagnostic.config({
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
				virtual_lines = false,
				virtual_text = {
					current_line = true,
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
			})

			local ensure_installed_dependend_servers = {
				"vue_ls",
			}
			---@class LspServersConfig
			---@field mason table<string, vim.lsp.Config>
			---@field others table<string, vim.lsp.Config>
			local servers = {
				mason = {
					angularls = {
						root_dir = lspUtil.root_pattern("angular.json"),
						root_markers = { "angular.json", "nx.json" },
					},
					ast_grep = {},
					biome = {},
					css_variables = {
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
						on_attach = function(client, buff_id)
							client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "#", "(" }
						end,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT" --[[ "Lua 5.1" ]],
									path = vim.split(package.path, ";"),
								},
								telemetry = { enable = false },
								diagnostics = {
									disable = { "missing-fields" },
									globals = { "after_each", "before_each", "describe", "it", "require", "vim" },
								},
								workspace = {
									ignoreSubmodules = true,
									library = { vim.env.VIMRUNTIME },
									checkThirdParty = false,
								},
								format = { enable = false },
								hint = { enable = true, setType = true },
							},
						},
					},
					marksman = {},
					mdx_analyzer = {},
					oxlint = {},
					phpactor = {},
					prettierd = {},
					somesass_ls = {
						filetypes = { "sass", "scss", "less", "css" },
					},
					stylua = {},
					tailwindcss = {
					  root_dir = function (file)
					    local util = require("lspconfig.util")
					    return util.root_pattern("tailwind.config.js", "tailwind.config.ts")(file)
					  end
					},
					ts_ls = {
						init_options = {
							plugins = {
								{
									name = "@vue/typescript-plugin",
									location = vim.fn.stdpath("data")
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
										enableProjectDiagnostics = true,
									},
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
								},
							},
						},
					},
					twiggy_language_server = {
						filetypes = { "html", "njk" },
					},
				},
				others = {},
			}

			local ensure_installed = vim.tbl_keys(servers.mason or {})
			vim.list_extend(ensure_installed, ensure_installed_dependend_servers)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for server, config in pairs(vim.tbl_extend("keep", servers.mason, servers.others)) do
				if not vim.tbl_isempty(config) then
					config.capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {})
					config.capabilities.textDocument = config.capabilities.textDocument or {}
					config.capabilities.textDocument.publishDiagnostics = {
						relatedInformation = true,
						versionSupport = true,
						tagSupport = { 1, 2 },
					}
					vim.lsp.config(server, config)
				end
			end

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_enable = true,
			})

			if not vim.tbl_isempty(servers.others) then
				vim.lsp.enable(vim.tbl_keys(servers.others))
			end
		end,
	},
}
