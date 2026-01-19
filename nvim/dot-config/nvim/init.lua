require("core.options")
require("core.keymaps")
require("core.augroups")
require("core.config")

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	change_detection = {
		notify = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	spec = {
		{ import = "plugins" },
		{ import = "plugins.editor" },
	},
}) ---[[@as LazyConfig]])

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "css", "javascript", "html", "markdown", "php", "scss", "typescript", "vue" },
	callback = function()
		vim.treesitter.start()
		vim.wo.foldlevel = 99
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function (event)
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     if client:supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
--
--       vim.notify("enable completion for " .. client.id, vim.log.levels.INFO)
--     end
--   end,
-- })
