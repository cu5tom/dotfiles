local function generateTodo()
  local matches = vim.fn.systemlist("rg TODO")

  local lines = {}
  table.insert(lines, "# TODOs:")

  for i = 1, #matches do
    local match = matches[i]
    local split = vim.fn.split(match, "TODO:")
    local todo = split[2]

    if todo ~= nil then
      table.insert(lines, "- [ ] " .. todo)
    end
  end

  vim.fn.writefile(lines, "TODO.md")
end

vim.api.nvim_create_user_command("GenerateTODO", function ()
  generateTodo()
end, { nargs = 0 })
