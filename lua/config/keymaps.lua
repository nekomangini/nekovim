local map = vim.keymap.set

--exit insert mode
map("i", "jk", "<ESC>")

-- Map Ctrl+h to move to the left window
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })

-- Map Ctrl+j to move to the window below
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })

-- Map Ctrl+k to move to the window above
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

-- Map Ctrl+l to move to the right window
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Cycle through Buffers
-- command from bufferline plugin/can also use :bnext and :bprevious
-- map('n', '[b', '<Cmd>BufferLineCyclePrev<cr>') -- go to next buffer
-- map('n', ']b', '<Cmd>BufferLineCycleNext<cr>') -- go to previous buffer
map("n", "[b", "<Cmd>bnext<cr>")     -- go to next buffer
map("n", "]b", "<Cmd>bprevious<cr>") -- go to previous buffer

-- split panes
map("n", "\\", "<C-w>s", { noremap = true, silent = true })
map("n", "|", "<C-w>v", { noremap = true, silent = true })

-- Esc to clear search highlight
map("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })

-- Scroll down and up and center
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Open oil.nvim
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Dismiss noice message
map("n", "<leader>N", "<Cmd>NoiceDismiss<CR>", { desc = "Dismiss noice message" })

-- Copy to system clipboard | Normal mode and Visual mode
-- map({ "n", "v" }, "y", [["+y]])
-- map({"n", "v"}, "y", "\"+Y")
-- map({ "n", "x" }, "<leader>y", '"+y')
map({ "n", "x" }, "y", "<Plug>(YankyYank)")
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
map("n", "[y", "<Plug>(YankyCycleForward)")
map("n", "]y", "<Plug>(YankyCycleBackward)")
map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
map("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
map("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
map("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
map("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
map("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
map("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
map("n", "=p", "<Plug>(YankyPutAfterFilter)")
map("n", "=P", "<Plug>(YankyPutBeforeFilter)")

map("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
map("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- delete without copying
map({ "n", "v" }, "<leader>d", "\"_d", { desc = "delete without copying" })

-- Shift current line down in normal mode
map("n", "<M-j>", ":m .+1<CR>==")

-- Shift current line up in normal mode
map("n", "<M-k>", ":m .-2<CR>==")

-- Shift visual selected lines down
map("v", "<M-j>", ":m '>+1<CR>gv=gv")

-- Shift visual selected lines up
map("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Diagnostic
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
-- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>")

-- terminal
-- map('n', '<leader>ft', '<cmd>Lspsaga term_toggle<cr>')

-- lsp keybind
map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
map("n", "gr", "<cmd>Lspsaga finder<cr>")
map("n", "gi", "<cmd>Lspsaga finder imp<cr>")
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "go", vim.lsp.buf.type_definition)
map("n", "gs", vim.lsp.buf.signature_help)
