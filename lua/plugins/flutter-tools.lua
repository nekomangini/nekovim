return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',   -- optional for vim.ui.select
      -- When you run FlutterDevices a popup will show up and that is the dressing.nvim
    },
    -- config = true,
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            require("dap.ext.vscode").load_launchjs()
          end,
        },
        lsp = {
          on_attach = on_attach,  -- Use your LSP on_attach function
          capabilities = capabilities,  -- Use your LSP capabilities
        },
      })
    end 
  }
}
