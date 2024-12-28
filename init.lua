require("config.lazy")
-- import keymaps from config folder
require("config.keymaps")
-- import settings from config folder
require("config.settings")

-- vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "tokyonight"
vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme "bamboo"
-- vim.cmd.colorscheme "cyberdream"
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
