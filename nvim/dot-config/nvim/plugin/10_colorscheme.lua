require("nightfox").setup({
	options = {
		dim_inactive = true,
		styles = {
			-- comments = "italic",
			-- constants = "bold",
			-- types = "italic,bold",
		},
	},
	palettes = {
		nordfox = {
		  -- bg1 = "#233440",
			comment = "#878788",
		},
	},
	specs = {
		nordfox = {
			syntax = {
				-- --  builtin0 = "yellow",
				-- --  builtin1 = "black",
				-- builtin2 = "orange.bright",
				-- conditional = "magenta.bright",
				-- const = "orange.bright",
				-- ident = "yellow.dim",
				-- --  field = "blue",
				-- func = "blue.dim",
				-- keyword = "magenta.bright",
				-- statement = "black",
				-- type = "yellow.bright",
				-- -- variable = "white.bright"
			},
		},
	},
})

vim.cmd.colorscheme("nordfox")

-- vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
-- require("vague").setup({ transparent = true })
-- vim.cmd.colorscheme("vague")
