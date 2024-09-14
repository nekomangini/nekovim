return {
  {
    "williamboman/mason.nvim",
    config = function()
      -- requires mason and calls setup
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- automatically install a language 
        -- auto_install = true,
        ensure_installed = { "lua_ls", "rust_analyzer" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup

      -- autocompletion using coq
      dependencies = {
      -- main one
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" }
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
        -- Your COQ settings here
      }
    end,

    config = function()
      local lspconfig = require("lspconfig")

      -- rust
      lspconfig.rust_analyzer.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ["rust-analyzer"] = {},
        },
      })

      -- lua
      lspconfig.lua_ls.setup({
        -- settings = {
        -- 	Lua = {
        -- 		workspace = {
        -- 			checkThirdParty = false,
        -- 		},
        -- 		codeLens = {
        -- 			enable = true,
        -- 		},
        -- 		completion = {
        -- 			callSnippet = "Replace",
        -- 		},
        -- 		doc = {
        -- 			privateName = { "^_" },
        -- 		},
        -- 		hint = {
        -- 			enable = true,
        -- 			setType = false,
        -- 			parmType = true,
        -- 			paramName = "Disable",
        -- 			semicolon = "Disable",
        -- 			arrayIndex = "Disable",
        -- 		},
        -- 	},
        -- },
      })
    end,
  },
}
