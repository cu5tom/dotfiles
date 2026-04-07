vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", {}),
	pattern = "*",
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		for _, winId in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winId).zindex then
				return
			end
		end

		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = true,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end,
	group = vim.api.nvim_create_augroup("LspDiagnosticsHold", {}),
	pattern = "*",
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- no auto comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)

		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- auto resize splits
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("ActiveCursorline", {}),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "ActiveCursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
