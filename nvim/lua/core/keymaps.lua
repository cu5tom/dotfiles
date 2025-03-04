vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

local opts = { noremap = true, silent = true }

-- Clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Save file
vim.keymap.set({"n", "i"}, "<C-s>", "<cmd>w<cr><Esc>", opts)

-- Move window focus
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", opts)
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", opts)
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", opts)
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", opts)

-- Resize window (respecting `v:count`)
vim.keymap.set("n", "<C-Left>",  "'<Cmd>vertical resize -' . v:count1 . '<CR>'", { expr = true, replace_keycodes = false, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Down>",  "'<Cmd>resize -'          . v:count1 . '<CR>'", { expr = true, replace_keycodes = false, desc = "Decrease window height" })
vim.keymap.set("n", "<C-Up>",    "'<Cmd>resize +'          . v:count1 . '<CR>'", { expr = true, replace_keycodes = false, desc = "Increase window height" })
vim.keymap.set("n", "<C-Right>", "'<Cmd>vertical resize +' . v:count1 . '<CR>'", { expr = true, replace_keycodes = false, desc = "Increase window width" })

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP')

-- Execute current buffer
vim.keymap.set("n", "<Space><Space>x", "<cmd>w<cr><cmd>source %<cr>", vim.tbl_extend("force", opts, { desc = "Execute current buffer" }))
