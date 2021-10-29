" Load modularized settings ------------------------------------------------ {{{

" Plugins installation and configuration
source ~/.config/nvim/plugins.vim

" Custom key bindings.
source ~/.config/nvim/mappings.vim

" Custom commands.
source ~/.config/nvim/commands.vim

" }}}

" General settings --------------------------------------------------------- {{{

" Set NeoVim cursor to the Vim default one, otherwise it shows a blinking thin
" line like in most GUI editors.
set guicursor=

" Use Unix line endings.
set fileformats=unix

" Always check spelling to improve grammar and prevent typos.
set spelllang=en_us
set spell

" Spaces & Tabs
" Always prefer spaces over tabs, use 2 spaces everywhere except in few
" languages (set in ~/.config/nvim/after/ftplugins/*.vim).
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround

" Add a vertical line to mark the line width limit so that its not exceeded.
set colorcolumn=81
highlight ColorColumn ctermbg=DarkBlue guibg=#2e5090

" Show both relative line numbers and the current line number (hybrid mode).
" This way it's easier to move around and perform motions.
set number
set relativenumber

" Highlight current line to improve aesthetics.
set cursorline

" Use true colors when available. This should work in most scenarios. If it
" doesn't, fall back to 256 colors.
if has('termguicolors')
  set termguicolors
else
  echoerr 'True colors are not available'
  set t_Co=256
endif

" Start scrolling when cursor is few lines off the bound so that a reasonable
" chunk of code around selected line is visible.
set scrolloff=10

" Only redraw when necessary so that the editor takes less resources.
set lazyredraw

" Highlight matching bracket.
set showmatch

" Search ignores case unless an uppercase letter appears in the pattern.
set ignorecase
set smartcase
" It is recommended to always keep the 'magic' option at the default setting
" for regular expressions.
set magic

" Don't create backup files.
set noswapfile
set nowritebackup

" Use better diff.
set diffopt+=internal,algorithm:patience,indent-heuristic

" Opens signcolumn by default so that errors, diagnostics and VCS markers
" (lines added/removed) do not trigger occasionally and shift borders all the
" time.
set signcolumn=yes

" Don't wait for updates too long.
set updatetime=100

" The fish shell is not compatible with most shells and unexpectedly breaks
" things that use 'shell'.
if &shell =~# 'fish$'
  set shell=bash
endif

" Make side scrolling more useful.
set sidescroll=5
set listchars+=precedes:<,extends:>

" Enable syntax highlighting.
syntax on

" }}}
