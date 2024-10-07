return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      -- requires mason and calls setup
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        -- automatically install a language
        -- auto_install = true,
        ensure_installed = { "lua_ls", "rust_analyzer", "volar" },
      })
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x', -- Use the latest v4.x version
    lazy = false,
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/nvim-cmp' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Set up LSP-Zero with recommended settings
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        -- LSP keymaps that are only active when LSP is attached
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
      end)

      -- Extend LSP settings
      lsp_zero.extend_lspconfig({
        sign_text = true,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      local lspconfig = require('lspconfig')

      -- Language server configurations
      lspconfig.gopls.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }, -- Avoid undefined 'vim'
            },
          },
        },
      })
      lspconfig.rust_analyzer.setup({})
      -- TODO:
      lspconfig.yamlls.setup({})
      lspconfig.ts_ls.setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
              languages = {"javascript", "typescript", "vue"},
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })
      lspconfig.volar.setup({
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      })

      -- nvim-cmp setup for autocompletion
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
          ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  --
  --   -- autocompletion using coq
  --   dependencies = {
  --     -- main one
  --     { "ms-jpq/coq_nvim",       branch = "coq" },
  --
  --     -- 9000+ Snippets
  --     { "ms-jpq/coq.artifacts",  branch = "artifacts" },
  --
  --     -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
  --     -- Need to **configure separately**
  --     { 'ms-jpq/coq.thirdparty', branch = "3p" }
  --     -- - shell repl
  --     -- - nvim lua api
  --     -- - scientific calculator
  --     -- - comment banner
  --     -- - etc
  --   },
  --   init = function()
  --     vim.g.coq_settings = {
  --       auto_start = false, -- if you want to start COQ at startup
  --       -- Your COQ settings here
  --     }
  --   end,
  --
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     local coq = require("coq")
  --
  --     -- rust
  --     -- lspconfig.rust_analyzer.setup({
  --     --   -- Server-specific settings. See `:help lspconfig-setup`
  --     --   settings = {
  --     --     ["rust-analyzer"] = {},
  --     --   },
  --     -- })
  --     lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
  --       -- Server-specific settings. See `:help lspconfig-setup`
  --       settings = {
  --         ["rust-analyzer"] = {},
  --       },
  --     }))
  --
  --     -- lua
  --     lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
  --       settings = {
  --         Lua = {
  --           workspace = {
  --             checkThirdParty = false,
  --           },
  --           codeLens = {
  --             enable = true,
  --           },
  --           completion = {
  --             callSnippet = "Replace",
  --           },
  --           doc = {
  --             privateName = { "^_" },
  --           },
  --           hint = {
  --             enable = true,
  --             setType = false,
  --             paramType = true,
  --             paramName = "Disable",
  --             semicolon = "Disable",
  --             arrayIndex = "Disable",
  --           },
  --         },
  --       },
  --     }))
  --     -- lspconfig.lua_ls.setup({
  --     --   -- settings = {
  --     --   -- 	Lua = {
  --     --   -- 		workspace = {
  --     --   -- 			checkThirdParty = false,
  --     --   -- 		},
  --     --   -- 		codeLens = {
  --     --   -- 			enable = true,
  --     --   -- 		},
  --     --   -- 		completion = {
  --     --   -- 			callSnippet = "Replace",
  --     --   -- 		},
  --     --   -- 		doc = {
  --     --   -- 			privateName = { "^_" },
  --     --   -- 		},
  --     --   -- 		hint = {
  --     --   -- 			enable = true,
  --     --   -- 			setType = false,
  --     --   -- 			parmType = true,
  --     --   -- 			paramName = "Disable",
  --     --   -- 			semicolon = "Disable",
  --     --   -- 			arrayIndex = "Disable",
  --     --   -- 		},
  --     --   -- 	},
  --     --   -- },
  --     -- })
  --
  --     -- vue (Volar setup)
  --     lspconfig.volar.setup(coq.lsp_ensure_capabilities({
  --       -- Enable Take Over Mode for both Vue and TypeScript files
  --       filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  --       -- Your other Volar settings here
  --     }))
  --     -- lspconfig.volar.setup({
  --     --   -- Enable Take Over Mode for both Vue and TypeScript files
  --     --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  --     --
  --     --   -- Overriding the default TypeScript server location (optional, configure if needed)
  --     --   -- Example using global TypeScript server:
  --     --   -- init_options = {
  --     --   --   typescript = {
  --     --   --     tsdk = '/home/nekomangini/.npm/lib/node_modules/typescript/lib', -- adjust this path if needed
  --     --   --   },
  --     --   -- },
  --     --
  --     --   -- Example for monorepos (optional):
  --     --   -- on_new_config = function(new_config, new_root_dir)
  --     --   --   local util = require 'lspconfig.util'
  --     --   --   local function get_typescript_server_path(root_dir)
  --     --   --     local global_ts = '/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib'
  --     --   --     local found_ts = util.path.join(root_dir, 'node_modules', 'typescript', 'lib')
  --     --   --     if util.path.exists(found_ts) then
  --     --   --       return found_ts
  --     --   --     else
  --     --   --       return global_ts
  --     --   --     end
  --     --   --   end
  --     --   --   new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  --     --   -- end,
  --     -- })
  --
  --     -- Override COQ's C-h binding
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       callback = function()
  --         vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
  --         vim.api.nvim_set_keymap('v', '<C-h>', '<C-w>h', { noremap = true, silent = true })
  --       end
  --     })
  --   end,
  -- },
}
