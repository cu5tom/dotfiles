vim.g.have_nerd_font = true
vim.g.lazydev_enabled = true

vim.o.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.backspace = vim.list_extend(vim.opt.backspace:get(), { "nostop" })
vim.opt.backup = false
vim.opt.breakindent = true
vim.schedule(function()
	vim.opt.clipboard:append("unnamedplus")
end)
vim.opt.cmdheight = 1
-- vim.opt.colorcolumn = "120"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.concealcursor = ""
vim.opt.conceallevel = 0
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.fillchars = { eob = " " }
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.iskeyword:append("-", "$", "@", "_")
vim.opt.jumpoptions = {}
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
-- vim.opt.listchars = { tab = "󰄾 ", trail = ".", nbsp = "󱁐" }
vim.opt.maxmempattern = 20000
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.preserveindent = true
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.redrawtime = 10000
vim.opt.relativenumber = true
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
vim.opt.scrolloff = 5
vim.opt.selection = "inclusive"
vim.opt.sessionoptions = "buffers,curdir,folds,globals,help,localoptions,tabpages,terminal,winsize"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true })
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes:3"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.winblend = 0
vim.opt.winborder = "rounded"
vim.opt.wrap = false
vim.opt.writebackup = false
