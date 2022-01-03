local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Use Gruvbox colorscheme.
  use 'morhetz/gruvbox'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', 'morhetz/gruvbox' },
    options = { theme = 'gruvbox' },
    config = function()
      require('lualine').setup()
    end,
  }

  use 'justinmk/vim-sneak'
  use 'mhinz/vim-signify'
  use {
    'mhinz/vim-startify',
    requires = {'kyazdani42/nvim-web-devicons' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
