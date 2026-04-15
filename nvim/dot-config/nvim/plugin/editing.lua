local loader = require("mini-loader")

local load_plugins = function()
	vim.pack.add({
		"https://github.com/numToStr/Comment.nvim",
		"https://github.com/cu5tom/nvim-ts-context-commentstring",
	})

	local comment = require("Comment")
	local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

	comment.setup({
		pre_hook = ts_context_commentstring.create_pre_hook(),
	})
end

loader.on_event("BufReadPre", load_plugins)
loader.on_event("BufNewFile", load_plugins)

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.bracketed").setup()

require("mini.cursorword").setup()

require("mini.icons").setup()

require("mini.indentscope").setup({
	draw = {
		animation = require("mini.indentscope").gen_animation.none(),
	},
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "@comment" })

require("mini.move").setup()

require("mini.operators").setup()

require("mini.pairs").setup()

require("mini.surround").setup()

require("mini.trailspace").setup()

-- require("mini.tabline").setup({
-- 	format = function(bufnr, label)
-- 		local suffix = vim.bo[bufnr].modified and "[+]" or "[" .. bufnr .. "]"
-- 		return MiniTabline.default_format(bufnr, label) .. suffix
-- 	end,
-- })
