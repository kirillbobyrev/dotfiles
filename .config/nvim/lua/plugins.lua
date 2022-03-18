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
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons',
  --   },
  --   config = function()
  --     require'nvim-tree'.setup()
  --   end,
  -- }

  use {
    'Yggdroot/indentLine',
    ft = { 'cpp', 'c', 'rust', 'python', 'lua', 'yaml' },
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  use 'justinmk/vim-sneak'
  use 'mhinz/vim-signify'
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
    end,
  }
  use 'wellle/targets.vim'

  use 'ledger/vim-ledger'

  -- Connect to LSP servers.
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').clangd.setup {}
      require('lspconfig').rust_analyzer.setup {}
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'nvim_lsp' },
        }
      })
    end,
  }
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  }
  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('rust-tools').setup()
      require('rust-tools.inlay_hints').set_inlay_hints()
    end,
  }

end)
