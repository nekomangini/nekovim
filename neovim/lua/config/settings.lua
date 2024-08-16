-- File: ~/.config/nvim/lua/config/settings.lua
-- Set tab width for Lua files to 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2      -- Number of spaces a <Tab> counts for
    vim.opt_local.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent
    vim.opt_local.expandtab = true -- Convert tabs to spaces
  end,
})

