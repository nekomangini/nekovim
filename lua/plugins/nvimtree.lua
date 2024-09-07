return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local api = require('nvim-tree.api')

    -- for conciseness
    local keymap = vim.keymap

    local function on_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file
          api.node.open.edit()
          -- Close the tree if file was opened
          api.tree.close()
        end
      end

      -- open as vsplit on current node
      local function vsplit_preview()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file as vsplit
          api.node.open.vertical()
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
      end

      -- On_attach mappings
      keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
      keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
      keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
      keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
    end

    require("nvim-tree").setup {
      on_attach = on_attach,
    }
    -- require("nvim-tree").setup {}

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
