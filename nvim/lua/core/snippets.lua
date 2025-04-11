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

local lsp_diagnostics_hold = vim.api.nvim_create_augroup("LspDiagnosticsHold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = lsp_diagnostics_hold,
  pattern = "*",
  callback = function()
    for _, winId in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winId).zindex then
        return
      end
    end
    vim.diagnostic.open_float({
      scope = "cursor",
      focusable = true,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave"
      }
    })
  end
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
