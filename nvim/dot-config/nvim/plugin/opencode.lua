local loader = require("mini-loader")

loader.later(function()
	vim.pack.add({ "https://github.com/NickvanDyke/opencode.nvim" })

	-- require("opencode").setup()

	vim.keymap.set("n", "<leader>ot", function()
		require("opencode").toggle()
	end)
end)
