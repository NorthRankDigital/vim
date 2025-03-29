-- Ensure Mason and Mason-LSPConfig are loaded
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "eslint", "tailwindcss", "cssls", "html", "emmet_ls", "astro", "marksman" }, -- Auto-install these servers
})

-- Load lspconfig and configure TypeScript and ESLint
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript/JavaScript (Using ts_ls instead of tsserver)
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Add keymaps and other customizations here if needed
  end,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  capabilities = capabilities,
})

-- ESLint (Fix: Use callback instead of command)
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
})

-- CSS (Fix: Typo in capabilities)
lspconfig.cssls.setup({
  on_attach = function(client, bufnr)
    -- Add keymaps and other customizations here if needed
  end,
  capabilities = capabilities,
})

-- HTML (Fix: Typo in capabilities)
lspconfig.html.setup({
  on_attach = function(client, bufnr)
    -- Add keymaps and other customizations here if needed
  end,
  filetypes = { "html" },
  capabilities = capabilities,
})

-- Emmet
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { "css", "html", "javascript", "sass", "scss" },
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
  on_attach = function(client, bufnr)
    -- Add keymaps and other customizations here if needed
  end,
  capabilities = capabilities,
  init_options = {
    typescript={},
  },
  filetypes = { "astro" },
})

-- Marksman
lspconfig.marksman.setup({
  on_attach = function(client, bufnr)
    -- Add custom keymaps or settings if needed
  end,
  capabilities = capabilities,
  filetypes = { "markdown" },
})
