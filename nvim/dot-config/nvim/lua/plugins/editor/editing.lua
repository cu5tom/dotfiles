return {
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- },
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
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

			local load_temp_rg = function(fn)
				local rg_env = "RIPGREP_CONFIG_PATH"
				local cached_rg_config = vim.uv.os_getenv(rg_env) or ""

				vim.uv.os_setenv(rg_env, vim.fn.stdpath("config") .. "/.rg")
				fn()
				vim.uv.os_setenv(rg_env, cached_rg_config)
			end

			require("mini.pick").setup()

			MiniPick.registry.buffers = function()
				local ns_id = vim.api.nvim_create_namespace("pick-buffers")

				local show = function(buf_id, items_to_show, query)
					MiniPick.default_show(buf_id, items_to_show, query, { show_icons = true })

					vim.api.nvim_buf_clear_namespace(buf_id, ns_id, 0, -1)
					local opts = { virt_text = { { "[+]", "Special" } }, virt_text_pos = "inline" }
					for i, item in ipairs(items_to_show) do
						if vim.bo[item.bufnr].modified then
							vim.api.nvim_buf_set_extmark(buf_id, ns_id, i - 1, 0, opts)
						end
					end
				end

				MiniPick.builtin.buffers(nil, {
					mappings = {
						wipeout = {
							char = "<C-d>",
							func = function()
								local items = MiniPick.get_picker_items()
								if not items then
									return
								end

								local bufnr = MiniPick.get_picker_matches().current.bufnr
								vim.api.nvim_buf_delete(bufnr, {})
								for i, item in ipairs(items) do
									if item.bufnr and item.bufnr == bufnr then
										items[i] = nil
									end
								end

								MiniPick.set_picker_items(items)

								vim.notify("Deleted buffer " .. bufnr, vim.log.levels.INFO)
							end,
						},
					},
					source = { show = show },
				})
			end

			require("mini.surround").setup()

			require("mini.tabline").setup({
				format = function(bufnr, label)
					local suffix = vim.bo[bufnr].modified and "[+]" or "[" .. bufnr .. "]"
					return MiniTabline.default_format(bufnr, label) .. suffix
				end,
			})
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
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
	-- {
	-- 	"folke/zen-mode.nvim",
	-- 	opts = {},
	-- },
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

			comment.setup({
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},
}
