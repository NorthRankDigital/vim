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

-- Manually load and apply configs from nvim-lspconfig
local lspconfig_path = vim.api.nvim_get_runtime_file('lsp/', false)[1]

local function load_config(name)
  local config_file = lspconfig_path .. name .. '.lua'
  local ok, config = pcall(dofile, config_file)
  if ok and config then
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  else
    vim.notify('Failed to load config for ' .. name, vim.log.levels.ERROR)
  end
end

-- Load servers (ESLint disabled)
load_config('ts_ls')
load_config('cssls')
load_config('html')
load_config('tailwindcss')
load_config('emmet_ls')
load_config('astro')
