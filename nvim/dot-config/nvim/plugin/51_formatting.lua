vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	notify_on_error = false,
	format_on_save = false,
	formatters_by_ft = {
		astro = { "oxfmt" },
		css = { "oxfmt" },
		htmldjango = { "djlint" },
		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		jinja = { "djlint" },
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
})

vim.keymap.set({ "n" }, "<leader>bf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { noremap = true, silent = true })
