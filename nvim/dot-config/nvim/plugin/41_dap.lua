require("mason-nvim-dap").setup({
	handlers = {},
	ensure_installed = {
		"js-debug-adapter",
		"php-debug-adapter",
	},
})

require("dapui").setup({
	expand_lines = true,
	controls = { enabled = false },
	floating = { border = "rounded" },
	render = {
		max_type_length = 60,
		max_value_lines = 200,
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 1.0 },
			},
			size = 15,
			position = "bottom",
		},
	},
})

require("dap").listeners.after.event_initialized["dapui_config"] = require("dapui").open
require("dap").listeners.before.event_terminated["dapui_config"] = require("dapui").close
require("dap").listeners.before.event_exited["dapui_config"] = require("dapui").close

vim.keymap.set("n", "<f5>", function()
	require("dap").continue()
end)

vim.keymap.set("n", "<f8>", function()
	require("dap").toggle_breakpoint()
end)

vim.keymap.set("n", "<f9>", function()
	require("dap").set_breakpoint(vim.ui.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<f10>", function()
	require("dap").step_over()
end)

vim.keymap.set("n", "<f11>", function()
	require("dap").step_into()
end)

vim.keymap.set("n", "<f12>", function()
	require("dap").step_out()
end)

vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle()
end)

require("dap").adapters = {
	["php"] = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
		cwd = "${workspaceFolder}",
	},
	["pwa-node"] = {
		type = "server",
		port = "${port}",
		executable = {
			command = "js-debug-adapter",
			args = {
				"${port}",
			},
		},
	},
}

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			port = 9229,
		},
	}

	require("dap").configurations.php = {
		{
			type = "php",
			request = "launch",
			name = "Listen for XDebug on Docker",
			port = 9003,
			pathMappings = {
				["/var/www/html"] = "${workspaceFolder}",
			},
		},
	}
end
