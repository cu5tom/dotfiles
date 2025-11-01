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
				astro = { "biome" },
				css = { "prettierd" },
				javascript = { "biome" },
				lua = { "stylua" },
				scss = { "prettierd" },
				sass = { "prettierd" },
				typescript = { "biome" },
				vue = { "biome" },
			},
		},
	},
}
