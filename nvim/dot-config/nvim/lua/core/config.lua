vim.hl.priorities.semantic_tokens = 95

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = {
		severity = vim.diagnostic.severity.ERROR,
	},
	update_in_insert = false,
	float = { source = "if_many" },
	severity_sort = true,
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

