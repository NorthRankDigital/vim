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
-- TypeScript/JavaScript (now includes MDX AND ASTRO)
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx", "mdx", "astro" },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  capabilities = capabilities,
})
vim.lsp.enable('ts_ls')

-- ESLint (now includes MDX)
vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "mdx" },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'package.json', '.git' },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.cmd("EslintFixAll")
      end,
    })
  end,
})
vim.lsp.enable('eslint')

-- CSS
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { "css", "scss", "sass", "less" },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})
vim.lsp.enable('cssls')

-- HTML
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { "html" },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})
vim.lsp.enable('html')

-- Emmet (now includes MDX)
vim.lsp.config('emmet_ls', {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { "css", "html", "javascript", "sass", "scss", "astro", "mdx" },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      }
    }
  }
})
vim.lsp.enable('emmet_ls')

-- Astro
vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { "astro" },
  root_markers = { 'astro.config.mjs', 'package.json', '.git' },
  capabilities = capabilities,
  init_options = {
    typescript = {},
  },
})
vim.lsp.enable('astro')

-- TailwindCSS (now includes MDX)
vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "mdx" },
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'package.json', '.git' },
  capabilities = capabilities,
})
vim.lsp.enable('tailwindcss')

-- Marksman (Markdown - now includes MDX)
vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { "markdown", "mdx" },
  root_markers = { '.git' },
  capabilities = capabilities,
})
vim.lsp.enable('marksman')

-- MDX Analyzer Language Server
vim.lsp.config('mdx_analyzer', {
  cmd = { "mdx-language-server", "--stdio" },
  filetypes = { "mdx" },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
  init_options = {
    typescript = {}
  },
})
vim.lsp.enable('mdx_analyzer')
