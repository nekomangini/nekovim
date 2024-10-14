return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
      -- When you run FlutterDevices a popup will show up and that is the dressing.nvim
    },
    -- config = true,
    -- TODO:
    config = function()
      local on_attach = function(client, bufnr)
        -- Define keybindings, etc. for LSP
      end
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("flutter-tools").setup({
        debugger = {
          enabled = true,
          run_via_dap = true,
          -- register_configurations = function(_)
          --   require("dap.ext.vscode").load_launchjs()
          -- end,
        },
        lsp = {
          on_attach = on_attach,       -- Use your LSP on_attach function
          capabilities = capabilities, -- Use your LSP capabilities
        },
      })
    end
  }
}
