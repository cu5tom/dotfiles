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
		"antosha417/nvim-lsp-file-operations",
		config = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			local lspUtil = require("lspconfig.util")

      vim.lsp.document_color.enable(true, nil, { style = "virtual" })

			vim.diagnostic.config({
				float = false,
        on_ready = function ()
          vim.cmd "highlight DiagnosticVirtualText guibg=NONE"
        end,
				severity_sort = true,
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				underline = {
					severity = vim.diagnostic.severity.ERROR,
				},
				update_in_insert = false,
				virtual_lines = false,
				virtual_text = {
					current_line = true,
          format = function (diagnostic)
            local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
            return string.format("%s %s", code, diagnostic.message)
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
						-- root_dir = lspUtil.root_pattern("angular.json"),
						-- root_markers = { "angular.json", "nx.json" },
					},
					-- ast_grep = {},
					css_variables = {
						-- capabilities = {
						-- 	textDocument = {
						-- 		completion = {
						-- 			completionItem = {
						-- 				snippetSupport = true,
						-- 			},
						-- 		},
						-- 	},
						-- },
					},
					-- cssls = {},
					emmet_ls = {},
					html = {
						filetypes = { "html", "phtml" },
					},
					gopls = {},
					jsonls = {
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
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
								},
								telemetry = { enable = false },
								diagnostics = {
									disable = { "missing-fields" },
									globals = { "after_each", "before_each", "describe", "it", "require", "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
							},
						},
					},
					marksman = {},
					mdx_analyzer = {},
					oxfmt = {},
					oxlint = {},
					phpactor = {
						filetypes = { "php", "phtml" },
					},
					["php-cs-fixer"] = {},
					somesass_ls = {
						filetypes = { "sass", "scss", "less", "css" },
					},
					stylua = {},
					tailwindcss = {
						root_dir = lspUtil.root_pattern("tailwind.config.js", "tailwind.config.ts"),
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
					local capabilities = config.capabilities or {}
					config.capabilities = require("blink.cmp").get_lsp_capabilities(
						vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), capabilities)
					)
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

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "html", "markdown", "php" },
				callback = function()
					require("otter").activate()
				end,
			})
		end,
	},
	{
		"jmbuhr/otter.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", branch = "main" },
		},
		opts = {},
	},
}
