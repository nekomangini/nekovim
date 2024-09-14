return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
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
