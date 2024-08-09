return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- init = function()
  --   vim.o.timeout = true
  --   vim.o.timeoutlen = 200
  -- end,
  -- opts = {
  --   plugins = {
  --     marks = true,
  --     registers = true,
  --     spelling = {
  --       enabled = true,
  --       suggestions = 20,
  --     },
  --     presets = {
  --       operators = false,
  --       motions = true,
  --       text_objects = true,
  --       windows = true,
  --       nav = true,
  --       z = true,
  --       g = true,
  --     },
  --   },
    -- icons = {
    --   breadcrumb = "»",
    --   -- separator = "➜",
    --   -- separator = "-",
    --   group = "+",
    -- },
    -- defaults = {
    --   mode = { "n", "v" },
    --   ["<leader>f"] = { name = "file" },
    --   ["<leader>b"] = { name = "buffer" },
    -- },
    -- win = {
    --   border = "rounded",
    --   position = "bottom",
    --   margin = { 1, 0, 1, 0 },
    --   padding = { 2, 2, 2, 2 },
    --   winblend = 0
    -- },
    -- layout = {
    --   height = { min = 4, max = 25 },
    --   width = { min = 20, max = 50 },
    --   spacing = 3,
    --   align = "left",
    -- },
    -- disable = {
    --   buftypes = {},
    --   filetypes = { "TelescopePrompt" },
    -- },
    -- show_help = true,
  -- },
  config = function()
    local wk = require("which-key")
    wk.add({
      
      -- buffer
      { "<leader>b", group = "buffer" },
      { "<leader>bD", "<cmd>bdelete!<cr>", desc = "Force Delete Buffer"},
      { "<leader>bb", "<cmd>Telescop buffers<cr>", desc = "Switch Buffer"},
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer"},
      { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer"},
      { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer"},
      
      -- file
      { "<leader>f", group = "find"},
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open REcent File" },
      { "<leader>fs", "<cmd>w<cr>", desc = "Save File" },

      -- { "<leader>h", "<cmd>Alpha<cr>", desc = "Home Screen" },

      -- { "<leader>q", group = "quit"},
      { "<leader>Q", "<cmd>qa<cr>", desc = "Quit Nekovim" },
      { "<leader>q", "<cmd>q<cr>", desc = "Quit Window" },

      { "<leader>w", "<cmd>w<cr>", desc = "Save" },
    })
  end,
}

-- default config
-- return {
--   "folke/which-key.nvim",
--   event = "VeryLazy",
--   init = function()
--     vim.o.timeout = true
--     vim.o.timeoutlen = 500
--   end,
--   opts = {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--   },
--   keys = {
--     {
--       "<leader>?",
--       function()
--         require("which-key").show({ global = false })
--       end,
--       desc = "Buffer Local Keymaps (which-key)",
--     },
--   },
-- }
