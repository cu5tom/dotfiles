vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		build = ":TSUpdate",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("treesitter-context").setup()

require("nvim-treesitter-textobjects").setup({
	move = {
		set_jumps = true,
	},
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
			["@class.outer"] = "V",
			["@conditional.outer"] = "V",
			["@loop.outer"] = "V",
		},
	},
})

local ts_select = require("nvim-treesitter-textobjects.select")

vim.keymap.set({ "x", "o" }, "aof", function()
	ts_select.select_textobject("@function.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "iof", function()
	ts_select.select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aoc", function()
	ts_select.select_textobject("@class.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ioc", function()
	ts_select.select_textobject("@class.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aoi", function()
	ts_select.select_textobject("@conditional.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ioi", function()
	ts_select.select_textobject("@conditional.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aol", function()
	ts_select.select_textobject("@loop.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "iol", function()
	ts_select.select_textobject("@loop.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aop", function()
	ts_select.select_textobject("@parameter.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "iop", function()
	ts_select.select_textobject("@parameter.inner", "textobjects")
end)

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
