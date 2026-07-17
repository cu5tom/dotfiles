require("mason").setup({})

require("mason-lspconfig").setup({})

require("mason-tool-installer").setup({
	ensure_installed = {
		"angularls",
		"clangd",
		"cssls",
		"css_variables",
		"djlint",
		"emmet_ls",
		"html",
		"jinja_lsp",
		"jsonls",
		"lua_ls",
		"oxfmt",
		"oxlint",
		"phpactor",
		"php-cs-fixer",
		"somesass_ls",
		"stylua",
		"taplo",
		"ts_ls",
		-- "tsgo",
		"vue_ls",
		"wc_ls",
	},
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.document_color.enable(true, nil, { style = "virtual" })

vim.lsp.config("jinja_lsp", {
	filetypes = { "nunjucks", "njk", "jinja", "html.jinja" },
	root_markers = { "package.json", ".git" },
})

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = { enable = false },
			runtime = {
				version = "LuaJIT",
				path = {
					"?.lua",
					"?/init.lua",
				},
			},
			workspace = {
				-- checkThirdParty = false,
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

vim.lsp.config("oxlint", {})

vim.lsp.config("taplo", {
	settings = {
		taplo = {
			schema = {
				associations = {
					[".*sesh\\.toml$"] = "https://github.com/joshmedeski/sesh/raw/main/sesh.schema.json",
					[".*flavor\\.toml$"] = "https://yazi-rs.github.io/schemas/theme.json",
				},
			},
		},
	},
})

vim.lsp.config("ts_ls", {
	init_options = {
		hostInfo = "neovim",
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
})

-- vim.lsp.config("tsgo", {
--   filetypes = {
-- 		"javascript",
-- 		"javascriptreact",
-- 		"typescript",
-- 		"typescriptreact",
--   },
-- })

vim.lsp.config("wc_ls", {})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("LspAttachConfig", { clear = true }),
--   callback = function (event)
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     if not client then
--       return
--     end
--
--     local bufnr = event.buf
--
--     local opts = { noremap = true, silent = true, buffer = bufnr }
--
--     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--     vim.keymap.set("n", "<leader>cd", function ()
--       vim.cmd("vsplit")
--       vim.lsp.buf.definition()
--     end, opts)
--     vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, opts)
--     vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
--     vim.keymap.set("n", "<leader>cR", vim.lsp.buf.references, opts)
--
--     if client:supports_method("textDocument/codeAction", bufnr) then
--       vim.keymap.set("n", "<leader>coi", function ()
--         vim.lsp.buf.code_action({
--           context = { only = { "source.organizeImports" }, diagnostics = {}},
--           apply = true,
--         })
--
--         vim.defer_fn(function ()
--           vim.lsp.buf.format({ bufnr = bufnr })
--         end, 50)
--       end)
--     end
--   end
-- })

vim.filetype.add({
	extension = {
		njk = "html.jinja",
	},
})
