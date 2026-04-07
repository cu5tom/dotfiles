vim.g.have_nerd_font = true
vim.g.lazydev_enabled = true

vim.opt.autoindent = true
vim.opt.backspace = vim.list_extend(vim.opt.backspace:get(), { "nostop" })
vim.opt.breakindent = true
vim.schedule(function ()
  vim.opt.clipboard = "unnamedplus"
end)
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.fillchars = { eob = " " }
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.formatoptions:remove({ "c" , "r", "o" })
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.infercase = true
vim.opt.iskeyword:append("-", "$", "@", "_")
vim.opt.jumpoptions = {}
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = "󰄾 ", trail = ".", nbsp = "󱁐" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.preserveindent = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
vim.opt.scrolloff = 5
vim.opt.sessionoptions = "buffers,curdir,folds,globals,help,localoptions,tabpages,terminal,winsize"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true })
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes:3"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.winborder = "rounded"
vim.opt.wrap = true
vim.opt.writebackup = false


vim.filetype.add({
  extension = {
    njk = "html",
  }
})

vim.lsp.document_color.enable(true, nil, { style = "virtual" })
