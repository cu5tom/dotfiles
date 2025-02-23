vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

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

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzv", opts)
vim.keymap.set("n", "N", "Nzzv", opts)

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)

-- Indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP')

-- local wk = require("which-key")
-- wk.add({
  -- Debug
  -- { "<leader>d", group = "Debug" },
  -- Packages
  -- { "<leader>p", group = "Packages" },
  -- { "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy" },
  -- { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },
  -- Find
  -- { "<leader>f", group = "Search" },
  -- { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
  -- { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
  -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file(s)" },
  -- { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word" },
  -- { "<leader>fW", "<cmd>Telescope live_grep<cr>", desc = "Find live word" },
  -- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
  -- { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
  -- { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Find man pages" },
  -- { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Find in quickfix" },
  -- { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
  -- { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Find registers" },
  -- { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Find vim options" },
  -- Git
--   { "<leader>g", group = "Git" },
--   {
--     mode = { "n", "v" },
--     { "<leader>q", "<cmd>q<cr>", desc = "Quit window" },
--     { "<leader>Q", "<cmd>qa<cr>", desc = "Quit nvim" }
--   }
-- })

