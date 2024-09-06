return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Function called when nvim-tree attaches to a buffer
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      -- Helper function to set keymap options
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- changes the <CR> "ENTER" to "l" to open a folder
      -- changes the <BS> "BACKSPACE" to "h" to close a folder
      -- Buffer local mappings.
      -- Use on_attach to only create mappings when nvim-tree attaches to a buffer
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    end

    -- Set up nvim-tree with the on_attach function
    require("nvim-tree").setup {
      on_attach = on_attach,
    }

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- Function to set buffer-local keymaps for nvim-tree using which-key
    keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
    keymap.set("n", "<leader>o", "<Cmd>NvimTreeFocus<CR>", { desc = "Toggle Focus" })
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
