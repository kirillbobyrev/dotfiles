vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Use Gruvbox colorscheme.
  use {
    'morhetz/gruvbox',
    config = function() 
      vim.o.termguicolors = true
      vim.cmd('colorscheme gruvbox')
    end,
  }

  use {
    'mhinz/vim-startify',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'morhetz/gruvbox'
    },
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', 'morhetz/gruvbox' },
    options = { theme = 'gruvbox' },
    config = function()
      require('lualine').setup()
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require'nvim-tree'.setup()
    end,
  }

  use {
    'Yggdroot/indentLine',
    ft = {'cpp', 'c', 'rust', 'python', 'lua'},
  }

  use 'justinmk/vim-sneak'
  use 'mhinz/vim-signify'
  use 'b3nj5m1n/kommentary'
  use 'wellle/targets.vim'

  -- Connect to LSP servers.
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').clangd.setup {}
      require('lspconfig').rust_analyzer.setup {}
    end,
  }
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require('rust-tools').setup()
    end,
  }
end)
