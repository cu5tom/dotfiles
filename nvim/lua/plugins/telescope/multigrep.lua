local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values
local whichkey = require("which-key")
local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then return nil end

      local parts = vim.split(prompt, "  ")
      local args = { "rg" }

      if parts[1] then
        table.insert(args, "-e")
        table.insert(args, parts[1])
      end

      if parts[2] then
        table.insert(args, "-g")
        table.insert(args, parts[2])
      end

      return vim
        .iter({
          args,
          { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      prompt_title = "Live Multi Grep",
      preview_title = "Multi Grep Preview",
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

M.setup = function()
  whichkey.add({ "<leader>fW", live_multigrep, desc = "Find words (multi grep)", mode = "n" })
end

return M
