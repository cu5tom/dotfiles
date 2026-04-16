# packages - Neovim Native Package Manager Wrapper

A simple wrapper around Neovim's native package manager (`vim.pack`) that provides lazy loading and event-based plugin management.

## Features

- **Lazy Loading**: Load plugins on specific vim events or file types
- **Dependency Management**: Declare and resolve plugin dependencies
- **Version Constraints**: Load plugins only for specific Neovim versions
- **Runtime Conditions**: Conditional loading based on runtime checks
- **Configurable Errors**: Per-plugin error handling strategies
- **Simple API**: Function-based registration

## Installation

Add to your `init.lua`:

```lua
-- First, add your desired plugins
require("packages").add("https://github.com/nvim-lua/plenary.nvim")

-- Then, load the wrapper module
require("packages")
```

## Basic Usage

### Simple Add

```lua
require("packages").add({
  plugin = "https://github.com/numToStr/Comment.nvim",
})
```

### With Setup Function

```lua
require("packages").add({
  plugin = "https://github.com/NeogitOrg/neogit",
  setup = function()
    local neogit = require("neogit")
    neogit.setup({
      integrations = { snacks = true },
    })
  end,
})
```

### Lazy Loading on Vim Event

```lua
require("packages").add({
  plugin = "https://github.com/lewis6991/gitsigns.nvim",
  on_load = "BufReadPre",  -- Load when buffer is read
  setup = function()
    local gs = require("gitsigns")
    gs.setup({ })
  end,
})
```

### Lazy Loading on File Type

```lua
require("packages").add({
  plugin = "https://github.com/stevearc/conform.nvim",
  on_ft = { "lua", "vim", "python" },  -- Load for these filetypes
  setup = function()
    require("conform").setup({
      format_on_save = { async = true, lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
      },
    })
  end,
})
```

### Dependencies

```lua
require("packages").add({
  plugin = "https://github.com/rcarriga/nvim-dap-ui",
  dependencies = { "nvim-dap" },  -- Load nvim-dap first
  setup = function()
    local dapui = require("dapui")
    dapui.setup({ })
  end,
})
```

### Version Constraints

```lua
require("packages").add({
  plugin = "https://github.com/folke/noice.nvim",
  version = "0.3.0",  -- Only load for this version (string or table of strings)
  setup = function()
    local noice = require("noice")
    noice.setup({ })
  end,
})
```

### Runtime Conditions

```lua
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
```

### Custom Error Handling

```lua
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
    nf.setup({ })
    vim.cmd("colorscheme nightfox")
  end,
})
```

## Error Handling Strategies

- `"silent"` - Do nothing, silently fail
- `"warn"` - Notify with warning level (default)
- `"error"` - Throw error and stop
- `"custom"` - Call custom handler function

## API Reference

### Adding Plugins

```lua
require("packages").add(spec)
```

Where `spec` can be:
- A string URL: `"https://github.com/user/repo"`
- A table with plugin spec: `{ plugin = "https://..." }`
- A plugin name table: `{ name = "plugin-name" }`

Options:
- `plugin` - Plugin spec (required)
- `on_load` - Vim event string or function
- `on_ft` - Filetype(s) or function
- `dependencies` - List of dependency names
- `version` - Version constraint
- `conditions` - List of runtime condition functions
- `setup` - Function to call after loading
- `error_handling` - Error handling strategy

### Event Registration

```lua
require("packages").on_event(event, spec)
```

### File Type Registration

```lua
require("packages").on_ft(filetypes, spec)
```

### Management Functions

```lua
require("packages").update()     -- Update all packages
require("packages").remove(name) -- Remove a plugin
require("packages").reload()     -- Reload all plugins
require("packages").load_pending()  -- Load all pending plugins
require("packages").load_all()     -- Load all plugins (ignoring lazy)
```

### Utility Functions

```lua
require("packages").has_plugin(name)      -- Check if plugin is registered
require("packages").is_loaded(name)       -- Check if plugin is loaded
require("packages").get_registry()        -- Get all registered plugins
require("packages").get_loaded()          -- Get all loaded plugins
require("packages").get_pending()         -- Get all pending plugins
require("packages").clear()               -- Clear all state
```

## Examples

See `lua/packages_examples.lua` for 23+ usage examples.

## Migration from mini-loader

If you were using `mini-loader`, you can migrate like this:

**Before:**
```lua
local loader = require("mini-loader")

loader.on_event("BufReadPre", function()
  vim.pack.add({ "https://github.com/NeogitOrg/neogit" })
  local neogit = require("neogit")
  neogit.setup({ })
end)
```

**After:**
```lua
require("packages").add({
  plugin = "https://github.com/NeogitOrg/neogit",
  on_load = "BufReadPre",
  setup = function()
    local neogit = require("neogit")
    neogit.setup({ })
  end,
})
```

## Notes

- Packages are stored in-memory and reset on restart
- Dependencies are loaded before the main plugin
- Version constraints use `vim.version()` checks
- Runtime conditions allow for complex logic
- All `setup()` functions run after package installation
