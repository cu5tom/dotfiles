return {
	"nemanjajojic/package-version.nvim",
	version = "*",
	dependencies = {
		"folke/which-key.nvim",
	},
	config = function()
		require("package-version").setup()
	end,
}
