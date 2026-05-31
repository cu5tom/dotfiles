local loader = require("mini-loader")

loader.later(function()
	vim.pack.add({ "https://github.com/folke/noice.nvim", "https://github.com/MunifTanjim/nui.nvim" })
	require("noice").setup({
		routes = {
			{
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			},
		},
		views = {
			mini = {
				position = {
					row = -2,
				},
			},
		},
	})
end)
