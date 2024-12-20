-- File: ~/.config/nvim/lua/config/settings.lua
-- Lua settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2      -- Number of spaces a <Tab> counts for
    vim.opt_local.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent
    vim.opt_local.expandtab = true -- Convert tabs to spaces
  end,
})

-- Vue settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vue",
  callback = function()
    vim.opt_local.commentstring = "// %s"
    -- Set tab space and indentation options
    vim.opt.tabstop = 2      -- Number of spaces that a <Tab> counts for
    vim.opt.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent
    vim.opt.expandtab = true -- Use spaces instead of tabs
  end,
})
