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
				ensure_installed = { "lua_ls", "rust_analyzer" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
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
