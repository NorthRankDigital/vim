-- Load lspconfig directly (bypassing Mason)
local lspconfig = require('lspconfig')

-- Default LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>vn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>va', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Add cmp_nvim_lsp capabilities
local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = cmp_ok and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- TypeScript/JavaScript (now includes MDX)
lspconfig.ts_ls.setup({
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx", "mdx" },
  capabilities = capabilities,
})

-- ESLint (now includes MDX)
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.cmd("EslintFixAll")
      end,
    })
  end,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "mdx" },
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  filetypes = { "css", "scss", "sass", "less" },
})

-- HTML
lspconfig.html.setup({
  filetypes = { "html" },
  capabilities = capabilities,
})

-- Emmet (now includes MDX)
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { "css", "html", "javascript", "sass", "scss", "astro", "mdx" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      }
    }
  }
})

-- Astro
lspconfig.astro.setup({
  capabilities = capabilities,
  init_options = {
    typescript = {},
  },
  filetypes = { "astro" },
})

-- TailwindCSS (now includes MDX)
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "mdx" },
})

-- Marksman (Markdown - now includes MDX)
lspconfig.marksman.setup({
  capabilities = capabilities,
  filetypes = { "markdown", "mdx" },
})

-- MDX Analyzer Language Server
lspconfig.mdx_analyzer.setup({
  cmd = { "mdx-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "mdx" },
  init_options = {
    typescript = {}
  },
})
