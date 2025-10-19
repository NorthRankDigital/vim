require("core.packer")
require("core.remap")
require("core.set")

-- File types
vim.filetype.add({
  extension = {
    mdx = 'markdown',
    astro = 'astro',
  },
})
