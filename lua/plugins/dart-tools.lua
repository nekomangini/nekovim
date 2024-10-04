return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',   -- optional for vim.ui.select
      -- When you run FlutterDevices a popup will show up and that is the dressing.nvim
    },
    config = true,
  }
}
