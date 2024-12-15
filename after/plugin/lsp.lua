-- Ensure Mason and Mason-LSPConfig are loaded
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "eslint", "tailwindcss" }, -- Auto-install these servers
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
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Add cmp_nvim_lsp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()


lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Add keymaps and other customizations here if needed
  end,
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    -- Auto-format on save, or other ESLint-specific settings
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

