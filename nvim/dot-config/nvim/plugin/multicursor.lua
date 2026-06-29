local cursors = {}
local chars_added_count = 0
local is_editing = false

local default_opts = { buf = 0 }

local group = vim.api.nvim_create_augroup("Multicursor", { clear = true })

local function add_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0);
  table.insert(cursors, cursor);
end

local function add_char_at_cursor(cursor, char, opts)
  local _opts = opts or default_opts

  local row = cursor[1] - 1
  local col = cursor[2] + chars_added_count - 1

  vim.api.nvim_buf_set_text(_opts.buf, row, col, row, col, { char })
end

local function is_current_cursor(cursor)
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  return current_cursor[1] == cursor[1]
end

local function add_char(char, opts)
  chars_added_count = chars_added_count + 1

  for _, cursor in pairs(cursors) do
    if is_current_cursor(cursor) then goto continue end

    add_char_at_cursor(cursor, char, opts)

    ::continue::
  end
end

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function ()
    if #cursors > 0 then
      is_editing = true
    end
  end
})

vim.api.nvim_create_autocmd("InsertLeavePre", {
  group = group,
	callback = function(args)
	  is_editing = false
	  cursors = {}
	  chars_added_count = 0
	end,
})

vim.api.nvim_create_autocmd("InsertCharPre", {
  group = group,
  callback = function (args)
    if not is_editing or #cursors == 0 then
      return
    end

    local buf = args.buf
    local char = vim.v.char

    vim.schedule(function ()
      add_char(char, { buf = buf })
    end)
  end
})

vim.keymap.set("n", "Q", add_cursor, {})
