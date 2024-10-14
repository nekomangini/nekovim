-- TODO:
return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      -- Set up highlights using the new API
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

      -- Define signs for DAP
      vim.fn.sign_define('DapBreakpoint',
        { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition',
        { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected',
        { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapLogPoint', {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl =
        'DapLogPoint'
      })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

      -- DAP configuration for Dart and Flutter
      dap.adapters.dart = {
        type = 'executable',
        command = 'dart',
        args = { 'debug_adapter' }
      }

      dap.adapters.flutter = {
        type = 'executable',
        command = 'flutter',
        args = { 'debug_adapter' }
      }

      local function find_main_dart()
        local current_file = vim.fn.expand("%:p")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")
        local found_file = vim.fn.findfile("lib/main.dart", current_dir .. ";")
        if found_file ~= "" then
          return found_file
        else
          print("Error: Could not find lib/main.dart")
          return nil
        end
      end
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch dart",
          dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
          flutterSdkPath = "/opt/flutter/bin/flutter",              -- ensure this is correct
          program = function()
            return find_main_dart()
          end,
          -- program = "${workspaceFolder}/lib/main.dart",             -- ensure this is correct
          cwd = "${workspaceFolder}",
        },
        {
          type = "flutter",
          request = "launch",
          name = "Launch Flutter",
          dartSdkPath = "/opt/flutter/bin/dart",       -- Adjust this path
          flutterSdkPath = "/opt/flutter/bin/flutter", -- Adjust this path
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        }
      }

      -- dart-repl configuration
      dap.configurations["dart-repl"] = {
        {
          type = "dart",
          request = "launch",
          name = "Dart REPL",
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
          repl = true,
        }
      }
    end
  }
}
