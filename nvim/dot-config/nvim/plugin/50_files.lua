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
			vim.notify(
				event.data.actions[1].type
					.. " "
					.. event.data.actions[1].src_url
					.. " "
					.. event.data.actions[1].dest_url,
				vim.log.levels.INFO
			)
			Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
		end
	end,
})

-- vim.keymap.set("n", "-", "<cmd>Oil --float<cr>")

vim.keymap.set('n', '-', function ()
  if vim.w.is_oil_win then
    require('oil').close()
  else
    require('oil').open_float(nil, { preview = {} })
  end
end)
