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
        ensure_installed = { "lua_ls", "rust_analyzer", "volar" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup

    -- autocompletion using coq
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim",       branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },

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
        auto_start = false, -- if you want to start COQ at startup
        -- Your COQ settings here
      }
    end,

    config = function()
      local lspconfig = require("lspconfig")
      local coq = require("coq")

      -- rust
      -- lspconfig.rust_analyzer.setup({
      --   -- Server-specific settings. See `:help lspconfig-setup`
      --   settings = {
      --     ["rust-analyzer"] = {},
      --   },
      -- })
      lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ["rust-analyzer"] = {},
        },
      }))
      
      -- lua
      lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      }))
      -- lspconfig.lua_ls.setup({
      --   -- settings = {
      --   -- 	Lua = {
      --   -- 		workspace = {
      --   -- 			checkThirdParty = false,
      --   -- 		},
      --   -- 		codeLens = {
      --   -- 			enable = true,
      --   -- 		},
      --   -- 		completion = {
      --   -- 			callSnippet = "Replace",
      --   -- 		},
      --   -- 		doc = {
      --   -- 			privateName = { "^_" },
      --   -- 		},
      --   -- 		hint = {
      --   -- 			enable = true,
      --   -- 			setType = false,
      --   -- 			parmType = true,
      --   -- 			paramName = "Disable",
      --   -- 			semicolon = "Disable",
      --   -- 			arrayIndex = "Disable",
      --   -- 		},
      --   -- 	},
      --   -- },
      -- })

      -- vue (Volar setup)
      lspconfig.volar.setup(coq.lsp_ensure_capabilities({
        -- Enable Take Over Mode for both Vue and TypeScript files
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        -- Your other Volar settings here
      }))
      -- lspconfig.volar.setup({
      --   -- Enable Take Over Mode for both Vue and TypeScript files
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      --
      --   -- Overriding the default TypeScript server location (optional, configure if needed)
      --   -- Example using global TypeScript server:
      --   -- init_options = {
      --   --   typescript = {
      --   --     tsdk = '/home/nekomangini/.npm/lib/node_modules/typescript/lib', -- adjust this path if needed
      --   --   },
      --   -- },
      --
      --   -- Example for monorepos (optional):
      --   -- on_new_config = function(new_config, new_root_dir)
      --   --   local util = require 'lspconfig.util'
      --   --   local function get_typescript_server_path(root_dir)
      --   --     local global_ts = '/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib'
      --   --     local found_ts = util.path.join(root_dir, 'node_modules', 'typescript', 'lib')
      --   --     if util.path.exists(found_ts) then
      --   --       return found_ts
      --   --     else
      --   --       return global_ts
      --   --     end
      --   --   end
      --   --   new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
      --   -- end,
      -- })
      
      -- Override COQ's C-h binding
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
          vim.api.nvim_set_keymap('v', '<C-h>', '<C-w>h', { noremap = true, silent = true })
        end
      })
    end,
  },
}
