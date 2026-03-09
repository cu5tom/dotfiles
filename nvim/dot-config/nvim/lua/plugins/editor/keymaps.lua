return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec", "disable.ft", "disable.bt" },
		opts = {
			delay = 0,
			icons = {
				group = vim.g.icons_enabled ~= false and "" or "+",
				rules = false,
				separator = "-",
			},
			plugins = {
				marks = true,
				registers = true,
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
		},
		config = function()
			local wk = require("which-key")

			wk.add({
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "Find/Files" },
				{ "<leader>g", group = "Git", mode = { "n", "v" } },
				{ "<leader>h", group = "Help" },
				{ "<leader>s", group = "Search" },
				{ "<leader>u", group = "UI" },
				{ "<leader>x", group = "Diagnostics" },
			})

			local utils = require("core.utils")
			local nmap_leader = utils.nmap_leader
			local nmap = utils.nmap

			nmap_leader("ba", "<Cmd>lua Snacks.bufdelete.all()<CR>", "Delete all")
			nmap_leader("bo", "<Cmd>lua Snacks.bufdelete.other()<CR>", "Delete other")
			nmap_leader("bd", "<Cmd>lua Snacks.bufdelete.delete()<CR>", "Delete")
			nmap_leader("bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")

			nmap_leader("ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
			nmap_leader("cd", "<Cmd>Pick lsp scope='definition'<CR>", "Definition")
			nmap_leader("ci", "<Cmd>Pick lsp scope='implementation'<CR>", "Implementation")
			nmap_leader("cr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
			nmap_leader("cR", "<Cmd>Pick lsp scope='references'<CR>", "References")
			nmap_leader("ct", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")

			nmap("gd", function()
				Snacks.picker.lsp_definitions()
			end, "Goto Definition")
			nmap("gD", function()
				Snacks.picker.lsp_declarations()
			end, "Goto Declaration")
			nmap("gI", function()
				Snacks.picker.lsp_implementations()
			end, "Goto Implementation")
			nmap("gR", function()
				Snacks.picker.lsp_references()
			end, "References")
			nmap("gy", function()
				Snacks.picker.lsp_type_definitions()
			end, "Goto T[y]pe Definition")

			nmap_leader("fb", "<Cmd>lua Snacks.picker.buffers()<CR>", "Buffers")
			nmap_leader("fc", "<Cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>", "Config Files")
			nmap_leader("ff", "<Cmd>lua Snacks.picker.files()<CR>", "Files")
			nmap_leader("fk", "<Cmd>lua Snacks.picker.keymaps()<CR>", "Keymaps")

			nmap_leader("hh", "<Cmd>lua Snacks.picker.help()<CR>", "Help pages")
			nmap_leader("hm", "<Cmd>lua Snacks.picker.man()<CR>", "Man pages")

			nmap_leader("n", "<Cmd>lua Snacks.picker.notifications()<CR>", "Notification history")

			nmap_leader("sb", function()
				Snacks.picker.grep_buffers()
			end, "Grep open Buffers")
			nmap_leader("sg", "<Cmd>lua Snacks.picker.grep()<CR>", "Grep live")
			nmap_leader("sG", "<Cmd>lua Snacks.picker.grep_word()<CR>", "Grep current word")
			nmap_leader("sr", "<Cmd>lua Snacks.picker.resume()<CR>", "Resume")
			nmap_leader("sd", function()
				Snacks.picker.diagnostics()
			end, "Diagnostics")
			nmap_leader("sD", function()
				Snacks.picker.diagnostics_buffer()
			end, "Buffer Diagnostics")

			nmap_leader("xd", "<Cmd>Pick diagnostic scope='all'<CR>", "Diagnostic workspace")
			nmap_leader("xD", "<Cmd>Pick diagnostic scope='current'<CR>", "Diagnostic buffer")
		end,
	},
}
