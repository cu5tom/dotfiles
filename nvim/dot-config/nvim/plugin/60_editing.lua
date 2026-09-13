local comment = require("Comment")
local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

comment.setup({
	pre_hook = ts_context_commentstring.create_pre_hook(),
})

require("mini.bracketed").setup()

require("mini.cursorword").setup()

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("mini.indentscope").setup({
	draw = {
		animation = require("mini.indentscope").gen_animation.none(),
	},
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "@comment" })

require("mini.move").setup()

require("mini.pairs").setup()

require("mini.surround").setup()

require("mini.trailspace").setup()

require("modicator").setup()
require("tabout").setup()
