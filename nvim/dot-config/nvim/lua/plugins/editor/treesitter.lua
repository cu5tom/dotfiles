return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		-- event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.install({
				"angular",
				"bash",
				"blade",
				"c",
				"comment",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"html",
				"htmldjango",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"php",
				"phpdoc",
				"python",
				"query",
				"regex",
				"scss",
				"sql",
				"tmux",
				"toml",
				"ts_query_ls",
				"tsx",
				"twig",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
}
