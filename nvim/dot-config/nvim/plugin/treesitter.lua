vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    build = ":TSUpdate"
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
  },
  "https://github.com/nvim-treesitter/nvim-treesitter-context"
})

require("treesitter-context").setup()

require("nvim-treesitter").install({
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
	"tsx",
	"twig",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"xml",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		vim.wo.foldlevel = 99
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		pcall(vim.treesitter.start, args.buf)
	end,
})
