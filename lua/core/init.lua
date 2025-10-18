require("core.packer")
require("core.remap")
require("core.set")
require("core.mason") 

-- File types
vim.filetype.add({
  extension = {
    mdx = 'markdown',
    astro = 'astro',
  },
})
