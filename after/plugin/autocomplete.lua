local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'buffer'},
  })
})

-- Add this to fix SCSS $ variable issues
cmp.setup.filetype('scss', {
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    -- Remove luasnip for SCSS files to prevent $ conflicts
  })
})
