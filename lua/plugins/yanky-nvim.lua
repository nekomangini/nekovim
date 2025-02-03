return {
  "gbprod/yanky.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    system_clipboard = {
      sync_with_ring = true, -- This enables automatic sync with system clipboard
    },
    highlight = {
      on_put  = true,
      on_yank = true,
      timer   = 160,
    },
  },
}
