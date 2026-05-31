vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		build = ":TSUpdate",
	},
	"https://github.com/MeanderingProgrammer/render-markdown.nvim"
})
