---@type LazySpec
return {
  {
    "echasnovski/mini.nvim",
    config = function()

      require("mini.move").setup()

      -- require("mini.sessions").setup {
      --   file = "",
      -- }

      require("mini.surround").setup()

      -- local function get_git_root()
      --   local path = vim.fn.system "git rev-parse --show-toplevel >/dev/null"
      --   if vim.v.shell_error == 0 then return path end
      --   return nil
      -- end
      --
      -- local function get_session_name()
      --   local dir = get_git_root() or vim.fn.getcwd()
      --   local branch = vim.fn.system "git branch --show-current"
      --   if vim.v.shell_error == 0 then return vim.fn.sha256(dir .. branch) end
      --   return vim.fn.sha256(dir)
      -- end
      --
      -- if vim.fn.argc(-1) == 0 then
      --   vim.api.nvim_create_autocmd({ "VimEnter", "focusGained" }, {
      --     nested = true,
      --     callback = function()
      --       local session_name = get_session_name()
      --
      --       if vim.v.this_session ~= "" then MiniSessions.write() end
      --
      --       if
      --         MiniSessions.detected[session_name] and string.find(vim.v.this_session, session_name, 1, true) == nil
      --       then
      --         MiniSessions.read(session_name)
      --       else
      --         MiniSessions.write(get_session_name())
      --       end
      --     end,
      --   })
      --
      --   vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
      --     callback = function()
      --       if vim.v.this_session == "" then return end
      --
      --       MiniSessions.write(get_session_name())
      --     end,
      --   })
      -- end
    end,
  },
}
