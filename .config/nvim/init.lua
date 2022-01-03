-- Load modularized settings ---------------------------------------------------

-- Plugins installation and configuration
require('plugins')

-- Custom key bindings.
vim.cmd('source ~/.config/nvim/mappings.vim')

-- Custom commands.
vim.cmd('source ~/.config/nvim/commands.vim')

-- }}}

-- Set options -----------------------------------------------------------------

-- Set NeoVim cursor to the Vim default one, otherwise it shows a blinking
-- thin line like in most GUI editors.
vim.o.guicursor = ''

-- Use Unix line endings.
vim.o.fileformats = 'unix'

-- Spaces & Tabs
-- Always prefer spaces over tabs, use 2 spaces everywhere except in few
-- languages (set in ~/.config/nvim/after/ftplugins/*.vim).
-- set tabstop=2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true

-- Add a vertical line to mark the line width limit so that its not exceeded.
vim.o.colorcolumn = '81'
vim.highlight.create('ColorColumn', {ctermbg=DarkBlue, guibg='#2e5090'}, false)

-- Show both relative line numbers and the current line number (hybrid mode).
-- This way it's easier to move around and perform motions.
vim.o.number = true
vim.o.relativenumber = true

-- Highlight current line to improve aesthetics.
vim.o.cursorline = true

-- Use true colors when available. This should work in most scenarios.
vim.o.termguicolors = true

-- Start scrolling when cursor is few lines off the bound so that a reasonable
-- chunk of code around selected line is visible.
vim.o.scrolloff = 10

-- Only redraw when necessary so that the editor takes less resources.
vim.o.lazyredraw = true

-- Highlight matching bracket.
vim.o.showmatch = true

-- Search ignores case unless an uppercase letter appears in the pattern.
vim.o.ignorecase = true
vim.o.smartcase = true
-- It is recommended to always keep the 'magic' option at the default setting
-- for regular expressions.
vim.o.magic = true

-- Don't create backup files.
vim.o.swapfile = false
vim.o.writebackup = false

-- Use better diff.
vim.o.diffopt = 'internal,algorithm:patience,indent-heuristic'

-- Opens signcolumn by default so that errors, diagnostics and VCS markers
-- (lines added/removed) do not trigger occasionally and shift borders all
-- the time.
vim.o.signcolumn = 'yes'

-- Don't wait for updates too long.
vim.o.updatetime = 50

-- The fish shell is not compatible with most shells and unexpectedly breaks
-- things that use 'shell'.
vim.o.shell = 'bash'

-- Make side scrolling more useful.
vim.o.sidescroll = 5
vim.opt.listchars = { precedes = '<', extends = '>' }

-- Required by treesitter to be set before it is enabled.
vim.o.filetype = 'on'
vim.o.syntax = 'on'

-- Sadly, this seems to be required for now:
-- https://github.com/kyazdani42/nvim-tree.lua/issues/767
require'nvim-tree'.setup {}
