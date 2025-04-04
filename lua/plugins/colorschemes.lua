return {
  -- cheshirecat
  {
    "nekomangini/cheshirecat.nvim",
    lazy = false,
    priority = 1000,
  },
  -- bloodmoon
  {
    "nekomangini/bloodmoon.nvim",
    lazy = false,
    priority = 1000,
  },
  -- iceberg
  {
    "oahlen/iceberg.nvim",
    lazy = false,
    priority = 1000,
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      style = "night",        -- the theme comes in three styles, 'storm', a darker variant 'night' and 'day', 'moon'
      -- light_style = "day",    -- the theme is used when the background is set to light
      transparent = false,    -- enable this to disable setting the background color
      terminal_colors = true, -- configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- style to be applied to different syntax groups
        -- value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- background styles. Can be "dark", "transparent", or "normal"
        sidebars = "transparent",
        floats = "dark",
      },
    },
  },

  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "",  -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    },
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = "mocha", -- change from latte
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
      term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,              -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,            -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,              -- Force no italic
      no_bold = false,                -- Force no bold
      no_underline = false,           -- Force no underline
      styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },      -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  -- bamboo theme
  {
    "ribru17/bamboo.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("bamboo").setup({
        -- optional configuration here
        -- Main options --
        -- NOTE: to use the light theme, set `vim.o.background = 'light'`
        style = "multiplex",                                      -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
        toggle_style_key = nil,                                   -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
        toggle_style_list = { "vulgaris", "multiplex", "light" }, -- List of styles to toggle between
        transparent = false,                                      -- Show/hide background
        dim_inactive = false,                                     -- Dim inactive windows/buffers
        term_colors = true,                                       -- Change terminal color as per the selected theme style
        ending_tildes = false,                                    -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false,                             -- reverse item kind highlights in cmp menu

        -- Change code style ---
        -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
        -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true },
          keywords = {},
          functions = {},
          namespaces = { italic = true },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = false,    -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      })
      require("bamboo").load()
    end,
  },

  -- cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
      highlights = {
        -- Highlight groups to override, adding new groups is also possible
        -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

        -- Example:
        Comment = { fg = "#696969", bg = "NONE", italic = true },

        -- Complete list can be found in `lua/cyberdream/theme.lua`
      },

      -- Override a highlight group entirely using the color palette
      -- NOTE: This function nullifies the `highlights` option
      overrides = function(colors)
        -- Example:
        return {
          Comment = { fg = colors.green, bg = "NONE", italic = true },
          ["@property"] = { fg = colors.magenta, bold = true },
        }
      end,

      -- Disable or enable colorscheme extensions
      extensions = {
        telescope = true,
        notify = true,
        mini = true,
      },
    },
    config = function()
      require("cyberdream").setup({
        transparent = false,       -- Enable transparent background
        italic_comments = false,   -- Enable italics comments
        hide_fillchars = false,    -- Replace all fillchars with ' ' for the ultimate clean look
        borderless_pickers = true, -- Modern borderless telescope theme - also applies to fzf-lua
        terminal_colors = true,    -- Set terminal colors used in `:terminal`
        cache = false,             -- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
      })
    end,
  },
  -- nordic
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        on_palette = function(palette) end,               -- This callback can be used to override the colors used in the base palette.
        after_palette = function(palette) end,            -- This callback can be used to override the colors used in the extended palette.
        on_highlight = function(highlights, palette) end, -- This callback can be used to override highlights before they are applied.
        bold_keywords = false,                            -- Enable bold keywords.
        italic_comments = true,                           -- Enable italic comments.
        transparent = {                                   -- Enable editor background transparency.
          bg = false,                                     -- Enable transparent background.
          float = false,                                  -- Enable transparent background for floating windows.
        },
        bright_border = false,                            -- Enable brighter float border.
        reduced_blue = true,                              -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        swap_backgrounds = false,                         -- Swap the dark background with the normal one.
        cursorline = {                                    -- Cursorline options.  Also includes visual/selection.
          bold = false,                                   -- Bold font in cursorline.
          bold_number = true,                             -- Bold cursorline number.
          theme = "dark",                                 -- Available styles: 'dark', 'light'.
          blend = 0.85,                                   -- Blending the cursorline bg with the buffer bg.
        },
        noice = { style = "classic" },                    -- Available styles: `classic`, `flat`.
        telescope = { style = "flat" },                   -- Available styles: `classic`, `flat`.
        leap = { dim_backdrop = false },                  -- Dims the backdrop when using leap.
        ts_context = { dark_background = true },          -- Enables dark background for treesitter-context window
      })
    end,
  },

  -- night fox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },

  -- aurora
  {
    "ray-x/aurora",
    init = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      vim.g.aurora_bold = 1
    end,
    config = function()
      vim.cmd.colorscheme("aurora")
      -- override defaults
      vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })
    end,
  },

  -- night-owl
  {
    "oxfist/night-owl.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")
    end,
  },
}
