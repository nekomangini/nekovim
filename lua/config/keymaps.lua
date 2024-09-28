-- local map = vim.keymap.set

--exit insert mode
-- map({ "i", "jk"}, "<ESC>",{ desc = "exit insert mode", remap = true })

local map = vim.keymap.set

-- Map Ctrl+h to move to the left window
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })

-- Map Ctrl+j to move to the window below
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })

-- Map Ctrl+k to move to the window above
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

-- Map Ctrl+l to move to the right window
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Cycle through Buffers
-- command from bufferline plugin/can also use :bnext and :bprevious
map('n', '[b', '<Cmd>BufferLineCyclePrev<cr>') -- go to next buffer
map('n', ']b', '<Cmd>BufferLineCycleNext<cr>') -- go to previous buffer

-- split panes
map('n', '\\', '<C-w>s', { noremap = true, silent = true })
map('n', '|', '<C-w>v', { noremap = true, silent = true })

-- Esc to clear search highlight
map('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })

-- Scroll down and up and center
map('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
map('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Open oil.nvim
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Dismiss noice message
map("n", "<leader>N", "<Cmd>NoiceDismiss<CR>", { desc = "Dismiss noice message" })

-- Moved to whichkey
-- remap $ and 0 to gl and gh
-- map('n', 'gl', '$', { noremap = true, silent = true }) -- moves the cursor to the end of the current line
-- map('n', 'gh', '0', { noremap = true, silent = true }) -- moves the cursor to the beginning of the current line
