-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.o.winblend = 70

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.autoformat = true
-- vim.opt.clipboard = ""

--vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.swapfile = false
-- vim.opt.undofile = true
-- vim.opt.undodir = os.getenv("Home") .. "/.local/state/nvim/undo"
vim.opt.spell = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
--vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolder
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
--vim.opt.mouse = ""

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m]"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m]"]])

-- Add asteriks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])
vim.cmd([[au BufNewFile,BufRead *.njk setf html]])
vim.cmd([[au BufNewFile,BufRead *.ejs setf html]])

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end
