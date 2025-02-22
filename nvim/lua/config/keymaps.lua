local wk = require("which-key")

wk.add({
  -- Debug
  { "<leader>d", group = "Debug" },
  -- Packages
  { "<leader>p", group = "Packages" },
  { "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy" },
  { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },
  -- Find
  { "<leader>f", group = "Search" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file(s)" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word" },
  { "<leader>fW", "<cmd>Telescope live_grep<cr>", desc = "Find live word" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
  { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Find man pages" },
  { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Find in quickfix" },
  { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
  { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Find registers" },
  { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Find vim options" },
  -- File explorer
  { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
  -- Git
  { "<leader>g", group = "Git" },
  {
    mode = { "n", "v" },
    { "<leader>q", "<cmd>q<cr>", desc = "Quit window" },
    { "<leader>Q", "<cmd>qa<cr>", desc = "Quit nvim" }
  }
})


