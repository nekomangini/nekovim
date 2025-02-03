return {
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      local noice = require("noice")
      -- fix: Gruvbox notification warning message
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
      })
      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          -- you can enable a preset by setting it to true, or a table that will override the preset config
          -- you can also add custom presets that you can enable/disable with enabled=true
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = false,      -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        },
        views = {
          -- minimalist setup
          -- cmdline_popup = {
          --   border = {
          --     style = "none",
          --     padding = { 2, 3 },
          --   },
          --   filter_options = {},
          --   win_options = {
          --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          --   },
          -- },
        },
        routes = {
          -- Hides search messages count
          {
            filter = {
              event = "msg_show",
              kind = "search_count",
            },
            opts = { skip = true },
          },
          -- Filter out the "ready" notification
          {
            filter = {
              event = "msg_show",
              find = "ready",
            },
            opts = { skip = true },
          },
        },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          -- available options for view = notify, split, vsplit, popup, mini, cmdline, cmdline_popup, cmdline_output, messages, confirm, hover
          -- view = "notify",          -- default view for messages
          view = "mini",               -- change this to see the resession popup
          view_error = "notify",       -- view for errors
          view_warn = "notify",        -- view for warnings
          view_history = "messages",   -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
      })
    end,
  },
}
