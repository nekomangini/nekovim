return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local api = require('nvim-tree.api')

    -- changes the <CR> "ENTER" to "l" to open a folder
    keymap.set("n", "l", api.node.open.edit)
    -- changes the <BS> "BACKSPACE" to "h" to close a folder
    keymap.set("n", "h", api.node.navigate.parent_close)
    keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
    keymap.set("n", "<leader>o", "<Cmd>NvimTreeFocus<CR>",  { desc = "Toggle Focus" })
    --  keymap.set("n", "<leader>o",
    --    function()
    --      if vim.bo.filetype == "nvim-tree" then
    --        vim.cmd.wincmd "p"
    --      else
    --        vim.cmd.NvimTreeFocus()
    --      end
    --    end,
    --    { desc = "Toggle Explorer Focus" }
    --  )
    -- keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    -- keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    -- keymap.set("n", "<leader>eo", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer"})
    -- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    -- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
