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

