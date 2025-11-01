local M = {}

M.nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

M.nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end

return M
