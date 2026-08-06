vim.pack.add({
	{ src = "https://github.com/nickvandyke/opencode.nvim", version = vim.version.range("*") },
})

local opencode_cmd = "opencode --port"

local snacks_terminal_opts = {
  win = {
    position = "right",
    enter = false
  }
}

vim.g.opencode_opts = {
  server = {
    start = function ()
      require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
    end
  }
}

vim.keymap.set({ "n", "t" }, "<M-t>", function ()
  require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
end)

vim.keymap.set({ "n", "x" }, "<M-a>", function ()
  require("opencode").ask("@this: ")
end)

vim.keymap.set({ "n", "x" }, "<M-x>", function ()
  require("opencode").select()
end)

vim.keymap.set({ "n", "x" }, "go", function ()
  return require("opencode").operator("@this ")
end)

vim.keymap.set({ "n" }, "goo", function ()
  return require("opencode").operator("@this ") .. "_"
end)
