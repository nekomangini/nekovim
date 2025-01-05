return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "dart",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "rust",
          "toml",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
      })
    end,
  },
}
