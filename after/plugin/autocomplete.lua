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


--local cmp = require('cmp')
--cmp.setup({
--  snippet = {
--    expand = function(args)
--      require('luasnip').lsp_expand(args.body)
--    end,
--  },
--  mapping = cmp.mapping.preset.insert({
--    ['<C-Space>'] = cmp.mapping.complete(),
--    ['<CR>'] = cmp.mapping.confirm({ select = true }),
--  }),
--  sources = {
--    { name = 'nvim_lsp' },
--    { name = 'luasnip' },
--  },
--})
--
---- Load LuaSnip and snippets
--require('luasnip.loaders.from_vscode').lazy_load()
--
---- Optional: Keybind for cycling through snippet placeholders
--vim.keymap.set({'i', 's'}, '<Tab>', function()
--  if require('luasnip').expand_or_jumpable() then
--    require('luasnip').expand_or_jump()
--  else
--    return '<Tab>'
--  end
--end, { expr = true })
--
--vim.keymap.set({'i', 's'}, '<S-Tab>', function()
--  if require('luasnip').jumpable(-1) then
--    require('luasnip').jump(-1)
--  end
--end, { expr = true })
