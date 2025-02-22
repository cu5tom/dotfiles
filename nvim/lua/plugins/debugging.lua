---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      {
        "<F5>",
        function ()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue"
      },
      {
        "<F1>",
        function ()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into"
      },
      {
        "<F2>",
        function ()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over"
      },
      {
        "<F3>",
        function ()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out"
      },
      {
        "<F7>",
        function ()
          require("dapui").toggle()
        end,
        desc = "Debug: See last session result."
      },
      {
        "<leader>db",
        function ()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint"
      },
      {
        "<leader>dB",
        function ()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition "))
        end,
        desc = "Set Breakpoint"
      }
    },
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "js-debug-adapter",
          "php-debug-adapter"
        }
      })

      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end
  }
}
