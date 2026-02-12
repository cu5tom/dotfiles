return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = false,
			formatters_by_ft = {
				astro = { "oxfmt" },
				css = { "oxfmt" },
				javascript = { "oxfmt" },
				javascriptreact = { "oxfmt" },
				json = { "oxfmt" },
				lua = { "stylua" },
				php = { "php-cs-fixer" },
				phtml = { "php-cs-fixer" },
				sass = { "oxfmt" },
				scss = { "oxfmt" },
				typescript = { "oxfmt" },
				typescriptreact = { "oxfmt" },
				vue = { "oxfmt" },
			},
		},
	},
}
