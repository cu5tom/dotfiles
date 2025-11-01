return {
	{
		"nvim-mini/mini.nvim",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
			},
		},
		version = false,
		config = function()
			local spec_treesitter = require("mini.ai").gen_spec.treesitter
			require("mini.ai").setup({
				use_nvim_treesitter = true,
				custom_textobjects = {
					F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
					o = spec_treesitter({
						a = { "@conditional.outer", "@loop.outer" },
						i = { "@conditional.inner", "@loop.inner" },
					}),
					["="] = spec_treesitter({
						i = "@assignment.lhs",
						a = "@assignment.rhs",
					}),
					A = spec_treesitter({
						i = "@attribute.inner",
						a = "@attribute.outer",
					}),
				},
			})

			require("mini.bracketed").setup()

			require("mini.bufremove").setup()

			require("mini.cursorword").setup()

			require("mini.extra").setup()

			require("mini.hipatterns").setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()fixme()%f[%w]", group = "minihipatternsfixme" },
					todo = { pattern = "%f[%w]()todo()%f[%w]", group = "minihipatternstodo" },
					note = { pattern = "%f[%w]()note()%f[%w]", group = "minihipatternsnote" },
				},
			})

			require("mini.icons").setup()

			require("mini.move").setup()

			require("mini.operators").setup()

			require("mini.pairs").setup()

			require("mini.pick").setup()

			require("mini.surround").setup()

			require("mini.tabline").setup()
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			vim.o.termguicolors = true
			require("nvim-highlight-colors").setup({
				render = "virtual",
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = { "o" },
				function()
					require("flash").remote()
				end,
				desc = "Flash Remote",
			},
			{
				"R",
				mode = { "x", "o" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-f>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Flash Toggle",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "lsp", "indent" }
				end,
			})

			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "zK", function()
				local winId = require("ufo").peekFoldedLinesUnderCursor()
				if not winId then
					vim.lsp.buf.hover()
				end
			end, { desc = "Peak fold" })
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			local comment = require("Comment")
			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			local ft = require("Comment.ft")
			ft.set({ "javascript", "typescript" }, { "//%s", "/*%s*/" })
			ft.set("html", "<!--%s-->")

			comment.setup({
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},
}
