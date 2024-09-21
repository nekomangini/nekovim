return {
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.34, -- amount of dimming
          color = { "Normal", "#ffffff" }, -- dimming color based on highlight groups or fallback
          term_bg = "#000000", -- background color if guibg=NONE
          inactive = false, -- fully dim other windows if true
        },
        context = 10, -- number of surrounding lines to show
        treesitter = true, -- use Treesitter for supported filetypes
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude certain filetypes from twilight
      })
    end,
    -- Optionally load it only when needed
    event = "BufReadPost",
  }
}

