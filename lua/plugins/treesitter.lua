return {
  {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
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
          "toml",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}
