return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = {},
    config = function()
      local ft = require('Comment.ft')

      -- Set comment strings for different file types
      ft.set('vue', {
        line = {
          script = '//%s',      -- Line comment for <script>
          template = '<!---->', -- Line comment for <template>
        },
        block = {
          script = '/*%s*/',    -- Block comment for <script>
          template = '<!---->', -- Block comment for <template>
        },
      })
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

        mappings = {
          basic = false, -- Disable the default `gcc`, `gc` mappings
          extra = false,
        }
      })
    end,
    -- Optionally add the event to load on demand
    event = "BufReadPost"
  }
}
