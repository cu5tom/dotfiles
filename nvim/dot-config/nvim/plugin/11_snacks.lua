vim.pack.add({ "https://github.com/folke/snacks.nvim" })

vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { link = "@diff.plus" })
vim.g.snacks_animate = false

require("snacks").setup({
	bigfile = { enabled = true },
	dim = { enabled = true },
	input = { enabled = true },
	lazygit = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	statuscolumn = { enabled = true },
})

vim.keymap.set({ "n" }, "<leader>ba", function()
	Snacks.bufdelete.all()
end)

vim.keymap.set({ "n" }, "<leader>bd", function()
	vim.notify("delete buffer", vim.log.levels.INFO)
	Snacks.bufdelete.delete()
end)

vim.keymap.set({ "n" }, "<leader>bo", function()
	Snacks.bufdelete.other()
end)

vim.keymap.set({ "n" }, "<leader>fb", function()
	Snacks.picker.buffers()
end)

vim.keymap.set({ "n" }, "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end)

vim.keymap.set({ "n" }, "<leader>ff", function()
	Snacks.picker.files()
end)

vim.keymap.set({ "n" }, "<leader>fk", function()
	Snacks.picker.keymaps()
end)

vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep()
end)

vim.keymap.set("n", "<leader>sG", function()
	Snacks.picker.grep_word()
end)

vim.keymap.set("n", "<leader>sr", function()
	Snacks.picker.resume()
end)

vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end)

vim.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end)
