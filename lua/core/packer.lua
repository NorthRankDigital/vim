local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Color Scheme
  use({
	  "folke/tokyonight.nvim",
	  -- Optional; default configuration will be used if setup isn't called.
	  config = function()
		  require("tokyonight").setup()
	  end,
  })

 use({'nvim-tree/nvim-tree.lua',
   requires = {
     'nvim-tree/nvim-web-devicons',
   }
 })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  -- LSP 
  use({'neovim/nvim-lspconfig'})
  use({'williamboman/mason.nvim'})
  use({'williamboman/mason-lspconfig.nvim'})

  -- Auto completion
  use({'hrsh7th/nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp'})
  use({'L3MON4D3/LuaSnip'})
  use({'saadparwaiz1/cmp_luasnip'})
  use({'rafamadriz/friendly-snippets'})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
