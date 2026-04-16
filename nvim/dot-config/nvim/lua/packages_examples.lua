-- Example 1: Basic usage with single file
-- Add a plugin that loads on BufEnter (every buffer)
require("packages").add({
  plugin = "https://github.com/nvim-lua/plenary.nvim",
  setup = function()
    -- plenary.nvim setup here
    require("plenary")
  end,
})

-- Example 2: Event-based lazy loading
require("packages").add({
  plugin = "https://github.com/NeogitOrg/neogit",
  on_load = "BufReadPre",  -- Load when opening a buffer
  setup = function()
    local neogit = require("neogit")
    neogit.setup({
      integrations = {
        snacks = true,
      },
    })
  end,
})

-- Example 3: File type based lazy loading
require("packages").add({
  plugin = "https://github.com/stevearc/conform.nvim",
  on_ft = { "lua", "vim", "python" },
  setup = function()
    require("conform").setup({
      format_on_save = {
        async = true,
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
      },
    })
  end,
})

-- Example 4: Multiple events
require("packages").add({
  plugin = "https://github.com/lewis6991/gitsigns.nvim",
  on_load = function() return vim.fn.mode() == "n" end,
  setup = function()
    local gs = require("gitsigns")
    gs.setup({
      signs = {
        add = { text = { "+", "?", "!" } },
        change = { text = { "~", "^", "~" } },
        delete = { text = { "-", "_", "~" } },
        topdelete = { text = { "~", "~", "~" } },
        deletemodified = { text = { "!", "!", "!" } },
      },
      word_diff = false,
    })
  end,
})

-- Example 5: Dependencies
require("packages").add({
  plugin = "https://github.com/rcarriga/nvim-dap-ui",
  dependencies = { "nvim-dap" },  -- Load nvim-dap first
  setup = function()
    local dapui = require("dapui")
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▶" },
    })
  end,
})

-- Example 6: Version constraints
require("packages").add({
  plugin = "https://github.com/folke/noice.nvim",
  version = "0.3.0",  -- Only load for these versions
  setup = function()
    local noice = require("noice")
    noice.setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
    })
  end,
})

-- Example 7: Runtime conditions
require("packages").add({
  plugin = "https://github.com/jackMort/zi.nvim",
  conditions = {
    function()
      -- Only load if vim.fn.exists is available
      return vim.fn.exists("quickfix_list_info") == 1
    end,
  },
  setup = function()
    local zi = require("zi")
    zi.setup()
  end,
})

-- Example 8: Custom error handling
require("packages").add({
  plugin = "https://github.com/numToStr/Comment.nvim",
  error_handling = "silent",  -- Don't warn on failure
  setup = function()
    local cn = require("Comment")
    cn.setup()
  end,
})

require("packages").add({
  plugin = "https://github.com/EdenEast/nightfox.nvim",
  error_handling = "error",  -- Throw error on failure
  setup = function()
    local nf = require("nightfox")
    nf.setup({
      highlights = {
        group = "Default",
      },
    })
    vim.cmd("colorscheme nightfox")
  end,
})

-- Example 9: Conditional loading based on environment
require("packages").add({
  plugin = "https://github.com/mfussenegger/nvim-dap",
  conditions = {
    function()
      -- Only load if we're not in a container
      local hostname = vim.fn.expand("%:p")
      return hostname ~= "/dev/fd/13"
    end,
  },
  setup = function()
    local dap = require("dap")
    dap.adapters.pylance = {
      type = "server",
      port = "${port}",
      host = "localhost",
      export = "stdio",
    }
    dap.adapters.vscode = function(callback, config)
      callback(config)
    end
  end,
})

-- Example 10: Complex file type matching
require("packages").add({
  plugin = "https://github.com/stevearc/oil.nvim",
  on_ft = function()
    -- Complex condition: only for specific directories
    local ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
    return ft == "oil"
  end,
  setup = function()
    local oil = require("oil")
    oil.setup({
      keymaps = {
        ["<C-l>"] = "cd",
        ["<C-h>"] = "close",
      },
    })
  end,
})

-- Example 11: Using with specific plugins (not URLs)
require("packages").add({
  plugin = {
    name = "nvim-treesitter",
    version = "main",
  },
  on_load = "VeryLazy",
  dependencies = { "nvim-treesitter-textobjects" },
  setup = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      ensure_installed = { "lua", "vim", "python", "javascript", "typescript" },
      auto_install = true,
    })
  end,
})

-- Example 12: Plugin management functions
-- Update all packages
require("packages").update()

-- Remove a plugin
require("packages").remove("neogit")

-- Reload all plugins
require("packages").reload()

-- Example 13: Check plugin status
if require("packages").has_plugin("plenary.nvim") then
  vim.notify("plenary.nvim is registered")
end

if require("packages").is_loaded("plenary.nvim") then
  vim.notify("plenary.nvim is loaded")
end

-- Example 14: Group related plugins
-- You can create a custom function to load a group
local function load_git_tools()
  require("packages").load_pending()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = load_git_tools,
})

-- Example 15: Quick add (shorthand)
-- Equivalent to: require("packages").add({ plugin = "..." })
require("packages").add("https://github.com/numToStr/Comment.nvim")

-- Example 16: Using mini-loader compatibility
-- If you want to keep using mini-loader, you can wrap packages
-- local loader = require("mini-loader")

-- This would still work with the old style:
-- loader.on_event("BufReadPre", function()
--   local neogit = require("neogit")
--   neogit.setup({ })
-- end)

-- But now you can also use the new packages system:
require("packages").on_event("BufReadPre", {
  plugin = "https://github.com/NeogitOrg/neogit",
  setup = function()
    local neogit = require("neogit")
    neogit.setup({ })
  end,
})

-- Example 17: Conditional based on plugin availability
require("packages").add({
  plugin = "https://github.com/nvim-lua/plenary.nvim",
  conditions = {
    function()
      -- Check if plenary.nvim is already installed
      return vim.fn.isdirectory(vim.fn.stdpath("data") .. "/lazy/plenary.nvim") == 1
    end,
  },
  setup = function()
    require("plenary")
  end,
})

-- Example 18: Event with custom function
require("packages").add({
  plugin = "https://github.com/folke/snacks.nvim",
  on_load = function()
    -- Check if we're in insert mode
    return vim.fn.mode() == "i"
  end,
  setup = function()
    local snacks = require("snacks")
    snacks.setup()
  end,
})

-- Example 19: Multiple conditions (OR logic)
require("packages").add({
  plugin = "https://github.com/nvim-tree/nvim-tree.lua",
  conditions = {
    function()
      -- Load if we're in a directory
      local cwd = vim.fn.getcwd()
      return cwd ~= ""
    end,
    function()
      -- Or load if it's a git repo
      return vim.fn.system("git rev-parse --git-dir") == ""
    end,
  },
  setup = function()
    local nvimtree = require("nvim-tree")
    nvimtree.setup({
      auto_reload_on_write = true,
    })
  end,
})

-- Example 20: Complete LSP setup
require("packages").add({
  plugin = "https://github.com/mason-org/mason-lspconfig.nvim",
  dependencies = { "mason.nvim", "mason-tool-installer.nvim" },
  setup = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "pyright", "clangd" },
      automatic_installation = true,
    })
  end,
})

-- Example 21: Session management
require("packages").add({
  plugin = "https://github.com/rmagatti/auto-session",
  on_ft = { "startuptime", "vim", "lua" },
  setup = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_save_enabled = true,
      log_level = "info",
      auto_close_dirs = true,
    })
  end,
})

-- Example 22: Diff view with git
require("packages").add({
  plugin = "https://github.com/sindrets/diffview.nvim",
  on_ft = { "gitcommit", "rebase", "diff" },
  dependencies = { "gitsigns.nvim" },
  setup = function()
    local diffview = require("diffview")
    diffview.setup({
      git_cmd = "git",
      disable_overview = false,
    })
  end,
})

-- Example 23: Using with completion plugins
require("packages").add({
  plugin = "https://github.com/saghen/blink.cmp",
  on_load = "CmdLineEnter",
  dependencies = { "blink.compat", "friendly-snippets" },
  setup = function()
    local blink = require("blink.cmp")
    blink.setup({
      keymap = {
        preset = "default",
        ["<C-n>"] = "select_next",
        ["<C-p>"] = "select_prev",
      },
    })
  end,
})
