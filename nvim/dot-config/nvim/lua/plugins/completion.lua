return {
	{
		"saghen/blink.compat",
		lazy = true,
		opts = {},
	},
	{
		---@module "blink.cmp"
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
      "SergioRibera/cmp-dotenv",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<C-y>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-j>"] = { "select_and_accept", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			sources = {
				default = {
					"lsp",
					"snippets",
					"path",
					"buffer",
				},
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
				  dotenv = {
            name = "dotenv",
            module = "blink.compat.source",
            opts = {},
				  },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			signature = {
				enabled = true,
				trigger = {
					enabled = true,
					show_on_keyword = true,
					blocked_retrigger_characters = {},
					blocked_trigger_characters = {},
					show_on_insert = true,
					show_on_trigger_character = true,
				},
				window = {
					direction_priority = { "n", "s" },
					show_documentation = true,
					treesitter_highlighting = true,
				},
			},
			snippets = {},
			term = {
				enabled = true,
				keymap = { preset = "inherit" },
				completion = {
					menu = { auto_show = true },
				},
			},
			cmdline = {
				enabled = true,
				keymap = { preset = "inherit" },
				completion = {
					menu = { auto_show = true },
				},
				sources = function()
					local type = vim.fn.getcmdtype()
					local res = {}

					if type == "/" or type == "?" then
						res = { "buffer" }
					end

					if type == ":" or type == "@" then
						res = { "cmdline", "buffer" }
					end

					return res
				end,
			},
			completion = {
				list = {
					selection = {
						preselect = function()
							return require("blink.cmp").snippet_active({ direction = 1 })
						end,
						auto_insert = false,
					},
					max_items = 50,
				},
				accept = { auto_brackets = { enabled = false } },
				keyword = { range = "full" },
				trigger = {
					show_in_snippet = true,
					show_on_trigger_character = true,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					update_delay_ms = 100,
					treesitter_highlighting = true,
					window = {
						winblend = 0,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						direction_priority = {
							menu_north = { "e", "w", "n", "s" },
							menu_south = { "e", "w", "s", "n" },
						},
					},
				},
				ghost_text = {
					enabled = true,
				},
				menu = {
					auto_show = true,
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_id" },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
			fuzzy = {
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
				implementation = "prefer_rust_with_warning",
			},
		},
	},
}
