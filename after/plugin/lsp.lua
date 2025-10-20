-- Default LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    
    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(false, event.buf)
    end
    
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

-- Simple approach - let configs auto-load
vim.lsp.enable('ts_ls')
vim.lsp.enable('cssls')
vim.lsp.enable('html')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('astro')
vim.lsp.enable('tailwindcss')

--[[ Servers to install
-- ts_ls:       npm install -g typescript typescript-language-server
-- cssls:       npm i -g vscode-langservers-extracted
-- html:        npm i -g vscode-langservers-extracted
-- emmet_ls:    npm i -g emmet-ls
-- astro:       npm install -g @astrojs/language-server
-- tailwindcss: npm install -g @tailwindcss/language-server
--]]
