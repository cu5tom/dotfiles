vim.highlight.priorities.semantic_tokens = 95

vim.diagnostic.config({
  virtual_text = {
    format = function (diagnostic)
      local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
      return string.format("%s %s", code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true
  },
  on_ready = function ()
    vim.cmd "highlight DiagnosticVirtualText guibg=NONE"
  end
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function ()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*"
})

P = function (v)
  print(vim.inspect(v))
  return v
end

RELOAD = function (...)
  return require("plenary.reload").reload_module(...)
end

R = function (name)
  RELOAD(name)
  return require(name)
end
