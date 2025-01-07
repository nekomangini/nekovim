return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    -- resession plugin
    local resession = require("resession")
    resession.setup()

    wk.setup({
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 5,      -- spacing between columns
      },
      show_help = true,   -- show a help message in the command line for using WhichKey
      show_keys = true,   -- show the currently pressed key and its label as a message in the command line
      plugins = {
        marks = true,     -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true,     -- misc bindings to work with windows
          z = true,       -- bindings for folds, spelling and others prefixed with z
          g = true,       -- bindings for prefixed with g
        },
      },

      -- sort = { "local", "order", "group", "alphanum", "mod" },
      sort = { "group" },

      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        -- separator = "➜", -- symbol used between a key and it's label
        separator = "-", -- symbol used between a key and it's label
        group = "+",  -- symbol prepended to a group
        ellipsis = "…",
        -- set to false to disable all mapping icons,
        -- both those explicitely added in a mapping
        -- and those from rules
        mappings = true,
        rules = {
          { pattern = "find", icon = " ", color = "green" },
          { pattern = "home", icon = "󰋜 ", color = "blue" },
          { pattern = "toggle", icon = "󰔡 ", color = "green" },
          { pattern = "quit", icon = "󰈆 ", color = "green" },
          { pattern = "save", icon = "󰆓 ", color = "green" },
          { pattern = "buffer", icon = " ", color = "green" },
          { pattern = "tools", icon = " ", color = "green" },
          { pattern = "plugin", icon = " ", color = "green" },
          { pattern = "terminal", icon = "  ", color = "green" },
          { pattern = "uppercase", icon = " ", color = "green" },
          { pattern = "lowercase", icon = " ", color = "green" },
          { pattern = "first", icon = "󰘀 ", color = "green" },
          { pattern = "last", icon = "󰘁 ", color = "green" },
        },
        -- use the highlights from mini.icons
        -- When `false`, it will use `WhichKeyIcon` instead
        colors = true,
        -- used by key format
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
    })
    wk.add({

      { "<leader>e",  "<cmd>Oil --float<cr>",       desc = "Open oil.nvim in a floating window" },

      -- buffer
      { "<leader>b",  group = "Buffer" },
      { "<leader>bD", "<cmd>bdelete!<cr>",          desc = "Force Delete Buffer" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
      { "<leader>bk", "<cmd>bdelete<cr>",           desc = "Delete Buffer" },

      -- Close all buffers except the current one
      {
        "<leader>bc",
        function()
          local current = vim.fn.bufnr("%")
          vim.cmd("silent! %bd|e#|bd#") -- Deletes all buffers except the current one
          vim.cmd("buffer " .. current) -- Reload the current buffer
          vim.cmd('echo "Closed all buffers except current"')
        end,
        desc = "Close all buffers except current",
      },

      -- Close the selected buffer
      {
        "<leader>bd",
        function()
          require("telescope.builtin").buffers({
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              -- Map <CR> to close the selected buffer
              map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.api.nvim_buf_delete(selection.bufnr, { force = false })
              end)

              -- Keep default mappings
              return true
            end,
          })
        end,
        desc = "Select and close buffer",
      },

      -- Close all buffers
      {
        "<leader>bC",
        function()
          local buffers = vim.api.nvim_list_bufs()
          for _, buf in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
              local buf_name = vim.api.nvim_buf_get_name(buf)
              if vim.api.nvim_buf_get_option(buf, "modified") == false and buf_name ~= "" then
                vim.api.nvim_buf_delete(buf, { force = true })
              end
            end
          end
        end,
        desc = "Close all buffers",
      },

      -- Horizontal split buffer
      {
        "<leader>b\\",
        function()
          require("telescope.builtin").buffers({
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Open the selected buffer in a horizontal split
                vim.cmd("split " .. selected_entry.value)
              end)
              return true
            end,
          })
        end,
        desc = "Select and open buffer in horizontal split",
      },

      -- Vertical split buffer
      {
        "<leader>b|",
        function()
          require("telescope.builtin").buffers({
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Open the selected buffer in a vertical split
                vim.cmd("vsplit " .. selected_entry.value)
              end)
              return true
            end,
          })
        end,
        desc = "Select and open buffer in vertical split",
      },
      -- Flutter keybindings
      { "<leader>f",  group = "Flutter tools" },
      { "<leader>fr", "<Cmd>FlutterRun<cr>",                          desc = "Flutter Run" },
      { "<leader>fl", "<Cmd>FlutterReload<cr>",                       desc = "Flutter Reload" },
      { "<leader>fs", "<Cmd>FlutterRestart<cr>",                      desc = "Flutter Restart" },
      { "<leader>fd", "<Cmd>FlutterDevices<cr>",                      desc = "Flutter Devices" },
      { "<leader>fp", "<Cmd>FlutterPubGet<cr>",                       desc = "Flutter Pub Get" },
      { "<leader>fu", "<Cmd>FlutterPubUpgrade<cr>",                   desc = "Flutter Pub Upgrade" },
      { "<leader>fq", "<Cmd>FlutterQuit<cr>",                         desc = "Flutter Quit" },
      -- Telescope
      { "<leader>s",  group = "Search" },
      { "<leader>sH", "<cmd>Telescope commands<cr>",                  desc = "Search Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                 desc = "Search Help" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                   desc = "Search Keymaps" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                  desc = "Search Recent Files" },
      { "<leader>sn", "<cmd>Telescope notify<cr>",                    desc = "Search Notifications" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",                desc = "Search Files" },
      { "<leader>sw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Words in Current Buffer" },
      { "<leader>sW", "<cmd>Telescope live_grep<cr>",                 desc = "Search Words In All Files" },
      {
        "<leader>sc",
        function()
          local word = vim.fn.expand("<cword>")
          require("telescope.builtin").current_buffer_fuzzy_find({
            default_text = word,
            prompt_title = "Search in Current Buffer",
          })
        end,
        desc = "Find Word References in Current Buffer",
      },
      { "<leader>sC", "<cmd>Telescope grep_string<cr>", desc = "Find Word References in Active Directory" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",         desc = "Find TODO" },
      -- { "<leader>ff", "<cmd>Telescope find_files<cr>",                                 desc = "Find File" },
      -- { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
      -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", },
      -- { "<leader>fs", "<cmd>w<cr>",     desc = "Save File" },
      -- { "<leader>h", "<cmd>Alpha<cr>", desc = "Home Screen" },

      -- { "<leader>q", group = "quit"},
      { "<leader>Q",  "<cmd>wq<cr>",                    desc = "Save and Quit" },
      { "<leader>q",  "<cmd>q<cr>",                     desc = "Quit" },

      { "<leader>w",  "<cmd>w<cr>",                     desc = "Save" },

      -- lazy and mason
      { "<leader>p",  group = "Plugins" },
      {
        "<leader>pu",
        "<cmd>Lazy update<cr><cmd>MasonUpdate<cr>",
        desc = "Update Lazy and Mason",
      },
      { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Plugin Install" },
      { "<leader>pm", "<cmd>Mason<cr>",        desc = "Mason Installer" },
      { "<leader>pM", "<cmd>MasonUpdate<cr>",  desc = "Mason Update" },
      { "<leader>ps", "<cmd>Lazy<cr>",         desc = "Plugins Status" },
      { "<leader>pS", "<cmd>Lazy sync<cr>",    desc = "Plugins Sync" },
      {
        "<leader>pc",
        "<cmd>Lazy check<cr>",
        desc = "Plugins Check Update",
      },
      { "<leader>pU", "<cmd>Lazy update<cr>",  desc = "Plugins Update" },

      -- lsp
      { "<leader>l",  group = "Language tools" },
      {
        "<leader>lh",
        vim.lsp.buf.hover,
        desc = "Hover diagnostics",
      },
      {
        "<leader>ld",
        vim.lsp.buf.definition,
        desc = "Go to Definition",
      },
      { "<leader>lF", vim.lsp.buf.references,         desc = "Find References" },
      { "<leader>lr", vim.lsp.buf.rename,             desc = "Rename" },
      -- { "<leader>la", vim.lsp.buf.code_action,                             desc = "Code Action" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format Code",
      },
      { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "<leader>lk", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },

      -- Home keybind for alpha.nvim
      { "<leader>h",  "<cmd>Alpha<cr>",         desc = "Home Screen" },

      { "<leader>n",  "<cmd>enew<cr>",          desc = "New File" },

      -- comment toggle
      {
        "<leader>/",
        function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "n" then
            require("Comment.api").toggle.linewise.current()
          elseif mode:match("[vV\22]") then -- v, V, or Ctrl+V (block mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
          end
        end,
        mode = { "n", "v" },
        desc = "Toggle Comment",
      },

      -- { "<leader>t",   group = "Extra tools" },
      -- PERF, HACK, TODO, NOTE, FIX, WARNING. Add a : after the word
      -- {
      --   "<leader>tn",
      --   function()
      --     require("todo-comments").jump_next()
      --   end,
      --   desc = "Next todo comment",
      -- },
      -- {
      --   "<leader>tp",
      --   function()
      --     require("todo-comments").jump_prev()
      --   end,
      --   desc = "Next todo comment",
      -- },
      -- You can also specify a list of valid jump keywords
      -- vim.keymap.set("n", "]t", function()
      --   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
      -- end, { desc = "Next error/warning todo comment" })
      -- terminal
      { "<leader>t",  group = "Terminal tools" },
      { "<leader>tf", "<cmd>Lspsaga term_toggle<cr>", desc = "ToggleTerm Float" },
      {
        "<leader>th",
        function()
          vim.opt.number = false        -- Toggles line numbers
          vim.opt.relativenumber = false -- Toggles relative number
          vim.cmd.vnew()                -- Creates a new vertical window
          vim.cmd.term()                -- Opens a terminal in the new window
          vim.cmd.wincmd("J")           -- Moves the terminal window to the bottom of the screen
          vim.api.nvim_win_set_height(0, 10) -- Sets the height of the current window to 10 lines
        end,
        desc = "ToggleTerm Horizontal",
      },

      -- trouble
      { "<leader>x",  group = "Tools" },
      { "<leader>xt", "<Cmd>Twilight<cr>", desc = "Toggle twilight" },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },

      -- resession
      { "<leader>S",  group = "Session tools" },
      { "<leader>Ss", resession.save,         desc = "Save Session" },
      { "<leader>Sl", resession.load,         desc = "Load Session" },
      { "<leader>Sd", resession.delete,       desc = "Delete Session" },
    })
  end,
}
