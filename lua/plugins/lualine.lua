return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled        = true,
        theme                = "cyberdream", --everforest, powerline, palenight, gruvbox, cyberdream
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = {
          statusline = {},
          winbar = {},
          "alpha",
        },
        ignore_focus         = {},
        always_divide_middle = true,
        globalstatus         = false,
        refresh              = {
          statusline = 1000,
          tabline    = 1000,
          winbar     = 1000,
        },
      },
      sections = {
        -- lualine_a = { "mode" },
        lualine_a = { "branch" },
        lualine_b = {
          {
            "filename",
            file_status     = true,   -- Displays file status (modified, read-only)
            path            = 1,      -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Filename and parent dir
            shorting_target = 40,     -- Shortens path if it's longer than 40 characters
            symbols         = {
              modified = " ●",        -- Text to show when the file is modified
              readonly = " ",         -- Text to show when the file is non-modifiable or readonly
              unnamed  = "[No Name]", -- Text to show for unnamed buffers
            },
          },
        },
        -- lualine_c = { 'filetype', 'diff', 'diagnostics' },
        lualine_c = {
          "diff",
          "diagnostics",
        },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        -- lualine_x = { 'buffers' },
        -- show @recording messages(bottom right side)
        lualine_x = {
          -- Noice recording status
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            -- color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          "filetype",
          -- Formatter status
          {
            function()
              local formatters = require("conform").list_formatters(0)
              if #formatters > 0 then
                return formatters[1].name
              end
              return "No formatter"
            end,
            icon = " ",
            cond = function()
              return package.loaded["conform"] ~= nil
            end,
          },
        },
        lualine_z = { "progress", "location" },
        -- lualine_z = { '%=', '%t%m', '%3p' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
