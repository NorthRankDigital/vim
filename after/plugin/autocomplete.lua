local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.close(), -- Add this to manually close completion
  }),
  snippet = {
    expand = function(args)
      -- Skip snippet expansion for SCSS files
      if vim.bo.filetype == 'scss' or vim.bo.filetype == 'sass' then
        return
      end
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'buffer'},
  })
})

-- Completely disable completion for SCSS variables
cmp.setup.filetype('scss', {
  enabled = function()
    -- Disable completion when typing $ variables
    local context = require('cmp.config.context')
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if line:sub(col, col) == '$' or line:sub(col-1, col-1) == '$' then
      return false
    end
    return true
  end,
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  })
})

-- Same for sass files
cmp.setup.filetype('sass', {
  enabled = function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if line:sub(col, col) == '$' or line:sub(col-1, col-1) == '$' then
      return false
    end
    return true
  end,
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  })
})
