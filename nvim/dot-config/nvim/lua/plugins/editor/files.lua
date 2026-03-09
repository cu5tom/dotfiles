return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = "Oil",
		config = function()
			require("oil").setup({
				keymaps = {
					["H"] = function()
						require("oil.actions").toggle_hidden.callback()
					end,
				},
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions[1].type == "move" then
					  vim.notify(event.data.actions[1].type .. ' ' .. event.data.actions[1].src_url .. ' ' .. event.data.actions[1].dest_url, vim.log.levels.INFO)
						Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
					end
				end,
			})
		end,
		keys = {
			{ "-", "<cmd>Oil --float<cr>", desc = "Oil" },
		},
	},
}
