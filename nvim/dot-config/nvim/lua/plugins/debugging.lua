---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
    },
    keys = {
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F1>",
        function() require("dap").step_into() end,
        desc = "Debug: Step Into",
      },
      {
        "<F2>",
        function() require("dap").step_over() end,
        desc = "Debug: Step Over",
      },
      {
        "<F3>",
        function() require("dap").step_out() end,
        desc = "Debug: Step Out",
      },
      {
        "<F7>",
        function() require("dapui").toggle() end,
        desc = "Debug: See last session result.",
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition ") end,
        desc = "Set Breakpoint",
      },
      {
        "<leader>du",
        function() require("dapui").toggle() end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      require("mason-nvim-dap").setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "js-debug-adapter",
          "php-debug-adapter",
        },
      }

      dapui.setup {
        expand_lines = true,
        controls = { enabled = false },
        floating = { border = "rounded" },
        render = {
          max_type_length = 60,
          max_value_lines = 200,
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 1.0 },
            },
            size = 15,
            position = "bottom",
          },
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      require("nvim-dap-virtual-text").setup({})

      require("dap-vscode-js").setup {
        debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
      }

      for _, language in ipairs { "typescript", "javascript" } do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            port = 9229,
          },
        }
      end
    end,
  },
}
