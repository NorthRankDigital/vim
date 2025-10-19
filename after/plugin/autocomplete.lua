local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ 
      select = true
    }),
    ['<C-e>'] = cmp.mapping.close(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },  
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  }),
  -- Filter out snippet completions
  formatting = {
    format = function(entry, vim_item)
      return vim_item
    end,
  },
  -- This is the key part - filter out snippets from ALL sources
  entries = {
    name = 'custom',
    selection_order = 'near-cursor',
  },
  matching = {
    disallow_symbol_nonprefix_matching = false,
  },
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  -- Filter function to remove snippets
  view = {
    entries = {name = 'custom', selection_order = 'near-cursor' }
  },
})

-- Add this to filter snippets globally
local types = require('cmp.types')
cmp.setup({
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      entry_filter = function(entry, ctx)
        -- Filter out snippet kind completions
        return entry:get_kind() ~= types.lsp.CompletionItemKind.Snippet
      end
    },
    {name = 'buffer'},
  })
})

-- SCSS/SASS configs...
cmp.setup.filetype('scss', {
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
