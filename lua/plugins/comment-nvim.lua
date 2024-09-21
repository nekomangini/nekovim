return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
      --  pre_hook = function(ctx)
      --    local U = require('Comment.utils')

      --    -- Determine whether to use // or <!-- --> based on file type
      --    local line = vim.api.nvim_get_current_line()

      --    if line:match("^%s*<script") then
      --      return "// "
      --    elseif line:match("^%s*<template") then
      --      return "<!---->"
      --    end
      --  end,
    },
    config = function()
      local ft = require('Comment.ft')

      -- Set comment strings for different file types
      ft.set('vue', {
        line = {
          script = '//%s',      -- Line comment for <script>
          template = '<!---->', -- Line comment for <template>
        },
        block = {
          script = '/*%s*/',    -- Block comment for <script>
          template = '<!---->', -- Block comment for <template>
        },
      })
      require('Comment').setup({
        mappings = {
          basic = false, -- Disable the default `gcc`, `gc` mappings
          extra = false,
        }
      })

      -- Keybindings for commenting
      -- vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('v', '<leader>/', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
    end,
    -- Optionally add the event to load on demand
    event = "BufReadPost"
  }
}
