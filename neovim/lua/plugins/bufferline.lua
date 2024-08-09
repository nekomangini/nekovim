return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup{
      options = {
        style_preset = require("bufferline").style_preset.slant,
        separator_style = "slant",
        indicator = {
          icon = '▎', -- This sets the indicator icon
          style = 'icon',
        },
        modified_icon = '●',
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        buffer_close_icon = 'x',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
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
