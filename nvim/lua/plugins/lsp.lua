local function trim(str)
  -- @type string
  str = str:gsub("^%s*(.-)%s*$", "%1")

  if string.sub(str, -1, -1) == "." then
    str = string.sub(str, 1, -2)
    str = str:gsub("^%s*(.-%s*$)", "%1")
  end

  return str
end

return {
  --  {
  --    "jose-elias-alvarez/null-ls.nvim",
  --    opts = function(_, opts)
  --      local nls = require("null-ls").builtins
  --      opts.sources = vim.list_extend(opts.sources or {}, {
  --        nls.formatting.biome,
  --      })
  --    end,
  --  }
}
