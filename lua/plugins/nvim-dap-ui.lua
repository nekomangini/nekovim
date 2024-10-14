return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      -- Open UI when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Close UI when debugging ends
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Prevent the UI from closing too early
      dap.listeners.after.event_stopped["dapui_config"] = function()
        dapui.open({ reset = false })
      end

      -- Keybindings
      vim.keymap.set("n", "<Leader>dU", dapui.toggle, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
    end
  }
}
