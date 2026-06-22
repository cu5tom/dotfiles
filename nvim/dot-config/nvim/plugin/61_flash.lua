require("flash").setup({
	modes = {
		char = {
			jump_labels = true,
		},
	},
})

vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

vim.keymap.set({ "o" }, "r", function()
	require("flash").remote()
end)
