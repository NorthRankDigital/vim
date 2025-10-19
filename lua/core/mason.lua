require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "eslint",
    "cssls", 
    "html",
    "emmet_ls",
    "astro",
    "tailwindcss",
    "marksman",
  },
  automatic_enable = false,  -- DISABLE auto-enable
})
