vim.pack.add({
	-- Colorscheme
	"https://github.com/EdenEast/nightfox.nvim",
	-- Session
	"https://github.com/rmagatti/auto-session",
	-- Files
	"https://github.com/stevearc/oil.nvim",
	-- Snacks
	"https://github.com/folke/snacks.nvim",
	-- Statusline
	"https://github.com/nvim-lualine/lualine.nvim",
	-- Completion
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/saghen/blink.compat",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
	-- Lsp
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	-- Dap
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/mxsdev/nvim-dap-vscode-js",
	"https://github.com/mfussenegger/nvim-dap",
	-- Treesitter
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		build = ":TSUpdate",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	-- Quickfix
	"https://github.com/stevearc/quicker.nvim",
	-- Notification
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- Comments
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/cu5tom/nvim-ts-context-commentstring",
	-- Mini
	"https://github.com/nvim-mini/mini.nvim",
	-- Formatting
	"https://github.com/stevearc/conform.nvim",
	-- Linting
	"https://github.com/mfussenegger/nvim-lint",
	-- Git
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	-- Markdown
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	-- Flash
	"https://github.com/folke/flash.nvim",
	-- DB
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	-- Tmux
	"https://github.com/alexghergh/nvim-tmux-navigation",
})
