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
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local default_setup = function(server)
        require("lspconfig")[server].setup({
          capabilities = lsp_capabilities,
        })
      end
      require("mason-lspconfig").setup({
        -- auto_install = true, -- automatically install a language
        ensure_installed = {
          "cssls",
          "emmet_ls",
          "eslint",
          "gopls",
          "html",
          "lua_ls",
          -- "prettier",
          "rust_analyzer",
          "taplo",
          "ts_ls",
          "volar",
          "vtsls",
        },
        handlers = {
          default_setup,
          -- Lua LSP specific configuration
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = lsp_capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    checkThirdParty = false,
                  },
                },
              },
            })
          end,

          -- TODO:
          -- Vue (Volar) configuration with Takeover Mode
          ["volar"] = function()
            require("lspconfig").volar.setup({
              filetypes = {
                "vue",
              },
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              init_options = {
                vue = {
                  hybridMode = false, -- Full Takeover Mode
                },
                typescript = {
                  tsdk = "/usr/local/lib/node_modules/typescript/lib",
                },
                autoUseWorkspaceTsdk = true,
                suggestFromUnimportedLibraries = true,
                preferences = {
                  importModuleSpecifier = "non-relative",
                },
              },
              on_new_config = function(new_config, new_root_dir)
                local function find_typescript_lib(root)
                  local possible_paths = {
                    root .. "/node_modules/typescript/lib",
                    "/usr/local/lib/node_modules/typescript/lib",
                    vim.fn.expand("~/.npm/lib/node_modules/typescript/lib"),
                    vim.fn.expand("~/.local/lib/node_modules/typescript/lib"),
                  }

                  for _, path in ipairs(possible_paths) do
                    if vim.fn.filereadable(path .. "/typescript.js") == 1 then
                      return path
                    end
                  end

                  return nil
                end

                local lib_path = find_typescript_lib(new_root_dir)
                if lib_path then
                  new_config.init_options.typescript.tsdk = lib_path
                end
              end,
            })
          end,

          -- VTSLS configuration
          -- ["vtsls"] = function()
          --   require("lspconfig").vtsls.setup({
          --     filetypes = {
          --       "vue",
          --     },
          --     settings = {
          --       vtsls = {
          --         autoUseWorkspaceTsdk = true,
          --         globalPlugins = {
          --           {
          --             name = "@vue/typescript-plugin",
          --             location = vim.fn.expand(
          --               "~/.local/lib/node_modules/@vue/typescript-plugin"
          --             ),
          --             languages = { "vue" },
          --           },
          --         },
          --       },
          --       typescript = {
          --         preferences = {
          --           importModuleSpecifier = "non-relative",
          --         },
          --       },
          --     },
          --   })
          -- end,

          -- ESLint configuration
          -- ["eslint"] = function()
          --   require("lspconfig").eslint.setup({
          --     on_attach = function(client, bufnr)
          --       vim.api.nvim_create_autocmd("BufWritePre", {
          --         buffer = bufnr,
          --         command = "EslintFixAll",
          --       })
          --     end,
          --   })
          -- end,
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.eslint,

          -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        },
      })
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x", -- Use the latest v4.x version
    lazy = false,
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/nvim-cmp" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(event)
        -- LSP keymaps that are only active when LSP is attached
        local opts = { buffer = event.buf }
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>Lspsaga finder imp<cr>", opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
      end)

      ---
      -- lsp setup
      --
      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      -- local lspconfig_defaults = require('lspconfig').util.default_config
      -- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      --   'force',
      --   lspconfig_defaults.capabilities,
      --   require('cmp_nvim_lsp').default_capabilities()
      -- )
      --
      -- moved to mason-lsp
      -- Extend LSP settings
      -- lsp_zero.extend_lspconfig({
      --   sign_text = true,
      --   capabilities = require("cmp_nvim_lsp").default_capabilities(),
      -- })
      --
      -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      ---
      -- moved to mason-lsp handlers
      -- Language server configurations
      --
      -- local lspconfig = require("lspconfig")
      -- lspconfig.dartls.setup({}) -- active in flutter-tools
      -- lspconfig.gopls.setup({})
      -- lspconfig.lua_ls.setup({
      --   -- on_init = function(client)
      --   --   lsp_zero.nvim_lua_settings(client, {})
      --   -- end,
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         globals = { "vim" }, -- Avoid undefined 'vim'
      --       },
      --     },
      --   },
      -- })
      -- lspconfig.rust_analyzer.setup({})
      -- lspconfig.taplo.setup({})
      -- lspconfig.ts_ls.setup({
      --   init_options = {
      --     plugins = {
      --       {
      --         name = "@vue/typescript-plugin",
      --         location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
      --         languages = { "javascript", "typescript", "vue" },
      --       },
      --     },
      --   },
      --   filetypes = {
      --     "javascript",
      --     "typescript",
      --     "vue",
      --   },
      -- })

      ---
      -- autocompletion config
      ---
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- local cmp_action = require("lsp-zero").cmp_action()

      cmp.setup({
        -- Sources for autocompletion
        sources = {
          { name = "nvim_lsp" }, -- Use LSP for autocompletion
          { name = "luasnip" }, -- luasnip
          { name = "buffer" }, -- Suggest words from the current buffer
          { name = "path" }, -- Suggest file paths
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),

          ["<C-e>"] = cmp.mapping.abort(),
        }),
        -- Enable documentation popups
        window = {
          documentation = cmp.config.window.bordered(), -- Nice border for documentation
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   },
      -- })
      -- `:` cmdline setup.
      -- cmp.setup.cmdline(":", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = "path" },
      --   }, {
      --     {
      --       name = "cmdline",
      --       option = {
      --         ignore_cmds = { "Man", "!" },
      --       },
      --     },
      --   }),
      -- })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",  -- optional
    },
    event = "LspAttach",              -- Load when LSP attaches
    config = function()
      require("lspsaga").setup({
        ui = {
          enable = true,
          sign = true,
        },
      })
    end,
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
