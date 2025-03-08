-- Indentation settings
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Show both relative line numbers and the current line number (hybrid mode).
-- This way it's easier to move around and perform motions.
vim.o.number = true
vim.o.relativenumber = true

-- Highlight matching bracket.
vim.o.showmatch = true

-- Setup plugins.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    main = "lualine",
    opts = {
      options = { icons_enabled = false }
    },
  },
  {
    'NoahTheDuke/vim-just',
    config = function()
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true },
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "rust",
        "bash",
        "html",
        "sql",
        "lua",
      }
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
})
