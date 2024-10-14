return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')
    require("bufferline").setup {
      options = {
        mode = "buffers",                               -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.default
        indicator = {
          -- icon = '▎', -- This shold be omitted if indicator style is not 'icon'
          icon = '',
          -- available values: icon, underline, none
          style = 'icon',
        },
        modified_icon = '●',
        color_icons = true, -- whether or not to add the filetype icon highlights
        buffer_close_icon = 'x',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true,  -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false, -- only applies to coc
        diagnostics_update_on_event = true,   -- use nvim's diagnostic handler
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   local icon = level:match("error") and " " or " "
        --   return " " .. icon .. count
        -- end,
        --- count is an integer representing total count of errors
        --- level is a string "error" | "warning"
        --- this should return a string
        --- Don't get too fancy as this function will be executed a lot
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or ""
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true
          }
        },
        show_tab_indicators = true,
        show_duplicate_prefix = true,    -- whether to show duplicate buffer prefix
        duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = true,      -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false,      -- whether or not the move command "wraps" at the first or last position
        show_buffer_icons = true,        -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        -- available separator_style "slant", "padded_slant", "slope", "padded_slope", "thick", "thin"
        separator_style = { "", "" },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        }
      }
    }
  end
}
-- return {
--   'akinsho/bufferline.nvim',
--   version = "*",
--   dependencies = 'nvim-tree/nvim-web-devicons',
--   config = function()
--     require("bufferline").setup{}
--     vim.opt.termguicolors = true
--   end
--
-- }
--
