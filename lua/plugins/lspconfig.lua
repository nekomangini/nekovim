return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- auto_install = true, -- automatically install a language
        ensure_installed = {
          "cssls",
          "emmet_ls",
          "eslint",
          "gopls",
          "html",
          "lua_ls",
          "marksman",
          "raku_navigator",
          "rust_analyzer",
          "taplo",
          "ts_ls",
          "volar",
          "vtsls",
          "yamlls",
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,

          ["raku_navigator"] = function()
            require("lspconfig").raku_navigator.setup({
              settings = {
                raku_navigator = {
                  rakuPath = "raku",
                },
              },
            })
          end,

          -- Vue (Volar) configuration with Takeover Mode
          ["volar"] = function()
            require("lspconfig").volar.setup({
              filetypes = {
                "vue",
              },
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

        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "marksman",
          "markdownlint-cli2",
          "markdown-toc",
          "prettier",
          "prettierd",
          "selene",
          "stylua",
          "yaml-language-server",
          "yamlfix",
        },
      })
    end,
  },

  -- formatter
  {
    "nvimtools/none-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      -- TODO:
      null_ls.setup({
        sources = {
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.completion.spell,

          -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua              = { "stylua" },

          -- You can customize some of the format options for the filetype (:help conform.format)
          rust             = { "rustfmt", lsp_format = "fallback" },

          -- Conform will run the first available formatter
          javascript       = { "prettierd", "prettier", stop_after_first = true },
          html             = { "prettierd", "prettier", stop_after_first = true },
          css              = { "prettierd", "prettier", stop_after_first = true },
          scss             = { "prettierd", "prettier", stop_after_first = true },
          less             = { "prettierd", "prettier", stop_after_first = true },
          postcss          = { "prettierd", "prettier", stop_after_first = true },
          vue              = { "prettierd", "prettier", stop_after_first = true },

          go               = { "goimports", "gofmt", lsp_format = "last" },
          ["markdown"]     = { "prettierd", "markdownlint-cli2", "markdown-toc" },
          ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        },
      })
    end,
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        markdown        = { "markdownlint-cli2" },
        typescriptreact = { "eslint_d" },
        vue             = { "eslint_d" },
      }

      -- Lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  -- lsp ui
  {
    "nvimdev/lspsaga.nvim",
    -- enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",     -- optional
    },
    event = "LspAttach",                 -- Load when LSP attaches
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,        -- Keep feature enabled
          sign = false,         -- Disable sign column light bulb
          virtual_text = false, -- Disable virtual text light bulb
          enable_in_insert = false,
        },
      })
    end,
  },
  -- snippet
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Sources for autocompletion
        sources = {
          { name = "nvim_lsp" }, -- Use LSP for autocompletion
          { name = "luasnip" },  -- luasnip
          { name = "buffer" },   -- Suggest words from the current buffer
          { name = "path" },     -- Suggest file paths
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
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(), -- Nice border for documentation
        },
      })

      -- Command line completion setup
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
          { name = "path" },
        },
      })

      -- Buffer completion setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
}
