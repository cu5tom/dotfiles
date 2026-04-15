vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup()

vim.opt.sessionoptions = "buffers,curdir,folds,globals,help,localoptions,tabpages,terminal,winsize"
