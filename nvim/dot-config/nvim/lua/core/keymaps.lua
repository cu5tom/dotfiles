vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Double escape from terminal" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("i", "jk", "<Esc>", opts)

-- Keep last yanked when pasting
vim.keymap.set("x", "p", '"_dP')

-- Clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Move window focus
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", opts)
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", opts)
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", opts)
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", opts)

-- Indentation
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end)

-- Disable arrow keys
local modes = { "n", "i", "o", "v", "t", "s", "x" }
local keys = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
	for _, key in ipairs(keys) do
		vim.keymap.set(mode, key, "<Nop>", opts)
	end
end

-- local enabledModes = { "c", "i", "o", "t", "s", "x" }
for _, mode in ipairs(modes) do
	vim.keymap.set(mode, "<A-h>", "<Left>", opts)
	vim.keymap.set(mode, "<A-j>", "<Down>", opts)
	vim.keymap.set(mode, "<A-k>", "<Up>", opts)
	vim.keymap.set(mode, "<A-l>", "<Right>", opts)
end

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<cr>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<cr>", opts)

vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<C-a>", "<C-]>", opts)
