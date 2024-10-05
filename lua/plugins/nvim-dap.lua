return {
  {
    'mfussenegger/nvim-dap',
    config = function ()
      local dap = require('dap')

      -- DAP configuration for Dart and Flutter
      dap.adapters.dart = {
        type = 'executable',
        command = 'dart',
        args = {'debug_adapter'}
      }

      dap.adapters.flutter = {
        type = 'executable',
        command = 'flutter',
        args = {'debug_adapter'}
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Dart",
          dartSdkPath = "/opt/flutter/bin/dart",  -- Adjust this path
          flutterSdkPath = "/opt/flutter/bin/flutter",  -- Adjust this path
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        },
        {
          type = "flutter",
          request = "launch",
          name = "Launch Flutter",
          dartSdkPath = "/path/to/dart-sdk",  -- Adjust this path
          flutterSdkPath = "/path/to/flutter",  -- Adjust this path
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        }
      }
    end
  }
}
