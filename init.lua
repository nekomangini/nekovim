require("config.lazy")
-- import keymaps from config folder
require("config.keymaps")
-- import settings from config folder
require("config.settings")

-- vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- vim.cmd.colorscheme("aurora")
vim.cmd.colorscheme("iceberg")
-- vim.cmd.colorscheme("cheshirecat")
-- vim.cmd.colorscheme("bloodmoon")
-- vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "tokyonight"
-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme "bamboo"
-- vim.cmd.colorscheme("cyberdream")
-- vim.cmd.colorscheme "nordic"
-- vim.cmd.colorscheme "duskfox"

-- vim.cmd.colorscheme "habamax"
-- vim.cmd.colorscheme "lunaperche"
-- vim.cmd.colorscheme "sorbet"
-- vim.cmd.colorscheme "zaibatsu"

vim.opt.fillchars:append({ eob = " " }) -- Replace ~ with a space in the end-of-buffer lines
-- start coq and don't show the greeter message
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "COQnow --shut-up"
-- })

-- neovide settings
if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here

	-- Text Settings
	-- vim.o.guifont = "Source Code Pro:h14"           -- default
	vim.o.guifont = "Hack:h11" -- text below applies for VimScript
	vim.g.neovide_text_gamma = 0.0
	vim.g.neovide_text_contrast = 0.5

	-- Transparency Settings
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * (vim.g.transparency or 0.2)))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.7
	-- vim.g.transparency = 0.9
	-- vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_background_color = "#6272A4" .. alpha()

	-- Cursor Settings
	vim.g.neovide_cursor_animation_length = 0.10 -- animation length
	vim.g.neovide_cursor_trail_size = 0.7 -- animation trail size
	vim.g.neovide_cursor_animate_in_insert_mode = true -- animate in insert mode
	-- available options for neovide_cursor_vfx_mode: railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
	vim.g.neovide_cursor_vfx_mode = "railgun" -- cursor particles
	vim.g.neovide_cursor_animate_command_line = true -- animate switch to command line
end
