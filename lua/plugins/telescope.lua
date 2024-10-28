return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
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
            ["<q>"] = actions.close, -- Add q to quit in insert mode
          },
          n = {
            ["q"] = actions.close, -- Add q to quit in normal mode
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
    { "<leader>fc", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
    { "<leader>fl", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",                   desc = "Keymaps" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>",               desc = "Find Word Definition" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    {
      "<leader>fw",
      function()
        local word = vim.fn.expand("<cword>")
        require('telescope.builtin').current_buffer_fuzzy_find({
          default_text = word,
          prompt_title = 'Search in Current Buffer'
        })
      end,
      desc = "Search word under cursor in buffer",
    }
    -- { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Find Buffers" },

    -- { "<leader>fn", "<cmd>enew<cr>",                  desc = "New File" },
    -- { "<leader>w",  proxy = "<c-w>",                  group = "windows" },
    -- {
  },
}
