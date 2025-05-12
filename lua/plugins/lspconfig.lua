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
          "clangd",
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
          -- "vtsls",
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
          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              init_options = {
                plugins = {
                  {
                    name = '@vue/typescript-plugin',
                    location = '/usr/local/lib/node_modules/@vue/language-server',
                    languages = { 'vue' },
                  },
                },
              },
              filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })
          end,
          ["volar"] = function()
            lspconfig.volar.setup({
              capabilities = capabilities,
            })
          end,
          ["clangd"] = function()
            lspconfig.clangd.setup({
              capabilities = capabilities,
              cmd = { "clangd", "--background-index=0", "--log=verbose" },
              init_options = {
                -- TODO:
                -- compilationDatabasePath = "/path/to/your/project/build",
                clangdFileStatus = { enabled = true },
              },
              flags = {
                "-I" .. "/usr/lib64/gcc/x86_64-suse-linux/14/include",
                "-I" .. "/usr/local/include",
                "-I" .. "/usr/lib64/gcc/x86_64-suse-linux/14/include-fixed",
                "-I" .. "/usr/lib64/gcc/x86_64-suse-linux/14/../../../../x86_64-suse-linux/include",
                "-I" .. "/usr/include",
                "-std=c++17",
              },
            })
          end,
        },
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
          prettier = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "emmet_ls",
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
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
          prettier = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })
    end,
  },

  -- formatter
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
          cpp              = { "clang_format" },
          c                = { "clang_format" },
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
        cpp             = { "cppcheck" },
        c               = { "cppcheck" },
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
      -- Explicitly load HTML and Vue snippets
      require("luasnip.loaders.from_vscode").lazy_load({ include = { "html", "vue" } })
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>']     = cmp.mapping.scroll_docs(-4),
          ['<C-f>']     = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
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
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
          prettier = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })

      -- Buffer completion setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
          prettier = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })
    end,
  },
}
