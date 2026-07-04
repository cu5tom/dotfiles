require("nightfox").setup({
	options = {
	  dim_inactive = true,
		styles = {
		  constants = "bold",
			types = "italic,bold",
		},
	},
	specs = {
		nordfox = {
			syntax = {
			 --  builtin0 = "yellow",
			 --  builtin1 = "black",
			  builtin2 = "orange.bright",
			  conditional = "magenta.bright",
			  const = "orange.bright",
			  ident = "yellow.dim",
			 --  field = "blue",
			  func = "blue.dim",
			  keyword = "magenta.bright",
			  statement = "black",
				type = "yellow.bright",
				-- variable = "white.bright"
			},
		},
	},
})

vim.cmd.colorscheme("nordfox")
