local function add_async()
  vim.api.nvim_feedkeys('t', 'n', true)

  local buffer = vim.fn.bufnr()

  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 4, vim.fn.col '.' - 1)
  if text_before_cursor ~= "awai" then
    return
  end

  local current_node = vim.treesitter.get_node({ ignore_injections = false })
  if not current_node then
    return
  end

  if current_node:type() == "comment" then
    return
  end

  local function_node = require("utils.treesitter").find_node_ancestor(
    {
      "arrow_function",
      "function_declaration",
      "function",
      "method_definition"
    },
    current_node
  )
  if not function_node then
    return
  end

  local function_text = vim.treesitter.get_node_text(function_node, 0)
  if
    vim.startswith(function_text, "async")
    or vim.startswith(function_text, "public async")
    or vim.startswith(function_text, "private async")
    or vim.startswith(function_text, "protected async")
  then
    return
  end

  local start_row, start_col = function_node:start()

  if vim.startswith(function_text, "public") then
    start_col = start_col + 7
  end

  if vim.startswith(function_text, "private") then
    start_col = start_col + 8
  end

  if vim.startswith(function_text, "protected") then
    start_col = start_col + 10
  end

  vim.api.nvim_buf_set_text(buffer, start_row, start_col, start_row, start_col, { "async " })
end

vim.keymap.set("i", "t", add_async, { buffer = 0 })
