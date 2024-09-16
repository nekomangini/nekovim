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
-- command from bufferline plugin
map('n', '[b', '<Cmd>BufferLineCyclePrev<cr>') -- go to next buffer
map('n', ']b', '<Cmd>BufferLineCycleNext<cr>') -- go to previous buffer
