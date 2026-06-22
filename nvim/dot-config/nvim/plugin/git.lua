local neogit = require("neogit")
neogit.setup({
	integrations = {
		snacks = true,
	},
})

vim.keymap.set("n", "<leader>gg", function()
	neogit.open({ kind = "split" })
end, { silent = true, noremap = true, desc = "Neogit" })

local gitsigns = require("gitsigns")

gitsigns.setup({
	current_line_blame = true,
	sign_priority = 50,
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		map("n", "<leader>hp", function()
			gitsigns.preview_hunk()
		end)
	end,
})
