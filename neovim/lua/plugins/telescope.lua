return {
  'nvim-telescope/telescope.nvim', 
  lazy = false,
  tag = '0.1.8',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load the FZF extension
    pcall(telescope.load_extension, 'fzf')
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
    { "<leader>w", proxy = "<c-w>", group = "windows" },
    { "<leader>b", group = "buffers", expand = function()
        return require("which-key.extras").expand.buf()
      end
    },
  },
}
-- return { 
--     -- init.lua: 
--     { 
--       'nvim-telescope/telescope.nvim', tag = '0.1.8',
--     -- or                              , branch = '0.1.x',
--       dependencies = { 'nvim-lua/plenary.nvim' },
--       keys = { 
--         { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
--         -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },
--         { "<leader>fn", desc = "New File" },
--         { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
--         { "<leader>b", group = "buffers", expand = function()
--             return require("which-key.extras").expand.buf()
--           end
--         },
--         -- {
--           -- Nested mappings are allowed and can be added in any order
--           -- Most attributes can be inherited or overridden on any level
--           -- There's no limit to the depth of nesting
--           -- mode = { "n", "v" }, -- NORMAL and VISUAL mode
--           -- { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
--           -- { "<leader>w", "<cmd>w<cr>", desc = "Write" },
--         -- },
--       },
--     },
-- }
