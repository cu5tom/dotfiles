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

