vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Double escape from terminal" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("i", "jk", "<Esc>", opts)

-- Clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Save file
-- vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<cr><Esc>", opts)

-- Navigate quickfix list
-- vim.keymap.set("n", "<M-x>", "<Cmd>cnext<CR>", vim.tbl_extend("force", opts, { desc = "Next Quickfix Item" }))
-- vim.keymap.set("n", "<M-y>", "<Cmd>cprev<CR>", vim.tbl_extend("force", opts, { desc = "Prev Quickfix Item" }))

-- Move window focus
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", opts)
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", opts)
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", opts)
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", opts)


-- Resize window (respecting `v:count`)
vim.keymap.set(
  "n",
  "<C-Left>",
  "'<Cmd>vertical resize -' . v:count1 . '<CR>'",
  { expr = true, replace_keycodes = false, desc = "Decrease window width" }
)
vim.keymap.set(
  "n",
  "<C-Down>",
  "'<Cmd>resize -'          . v:count1 . '<CR>'",
  { expr = true, replace_keycodes = false, desc = "Decrease window height" }
)
vim.keymap.set(
  "n",
  "<C-Up>",
  "'<Cmd>resize +'          . v:count1 . '<CR>'",
  { expr = true, replace_keycodes = false, desc = "Increase window height" }
)
vim.keymap.set(
  "n",
  "<C-Right>",
  "'<Cmd>vertical resize +' . v:count1 . '<CR>'",
  { expr = true, replace_keycodes = false, desc = "Increase window width" }
)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Indenting
-- vim.keymap.set("v", "<", "<gv", opts)
-- vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<M-Left>", "<gv", opts)
vim.keymap.set("v", "<M-Right>", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP')

-- Execute current buffer
vim.keymap.set(
  "n",
  "<Space><Space>x",
  "<cmd>w<cr><cmd>source %<cr>",
  vim.tbl_extend("force", opts, { desc = "Execute current buffer" })
)

-- vim.keymap.set("n", "<C-c>", "ciw", opts)
-- Terminal
-- local job_id = 0
-- vim.keymap.set("n", "<space>Ts", function()
--   vim.cmd.vnew()
--   vim.cmd.term()
--   vim.cmd.wincmd "J"
--   vim.api.nvim_win_set_height(0, 15)
--
--   job_id = vim.bo.channel
-- end, vim.tbl_extend("force", opts, { desc = "New Terminal" }))

-- vim.keymap.set("n", "<space>example", function() vim.fn.chansend(job_id, { "ls -la\r\n" }) end)
