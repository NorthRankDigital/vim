require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "ts_ls",
    "eslint",
    "html",
    "cssls",
    "tailwindcss",
    "emmet_ls",
    "marksman",
  },
  automatic_installation = true,
})
