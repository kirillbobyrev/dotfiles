""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO(omtcvxyz): get through docs, personalize some plugins.
" Use different locations for NeoVim and Vim.
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
" Install Plugins
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
" The following section contains NeoVim-specific plugins which rely on
" additional features such as NeoVim async model.
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'zchee/deoplete-clang'
  Plug 'zchee/deoplete-jedi'
endif
call plug#end()

" Plugins-specific settings

" Correctly initialize Deoplete.nvim & language-specific friends
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
  let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/6.0.0/include/'

  let g:deoplete#sources#rust#racer_binary = '/home/omtcvxyz/.cargo/bin/racer'
  let g:deoplete#sources#rust#rust_source_path = '/home/omtcvxyz/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
endif

" vim-airline statusbar
let g:airline_theme = 'gruvbox'

" ale linters
" TODO(omtcvxyz): For now, probably whitelist trusted linters, otherwise ale
" is quite slow. For the future, blacklist untrusted ones:
" https://github.com/w0rp/ale/issues/1453
let g:ale_cpp_clangtidy_checks = ['performance-*', 'modernize-*']
let g:ale_sign_column_always = 1

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}

" Gruvbox colorscheme {{{
" Use Italics regardless of GUI being disabled
set t_Co=256
let g:gruvbox_italic = 1
set background=dark
colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always use UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf8

" Use Unix line endings
set fileformats=unix

" Enable filetype plugin
filetype plugin indent on

" Always check spelling to improve grammar and prevent typos
set spell spelllang=en_us

" Spaces & Tabs
" Always prefer spaces over tabs, use 2 spaces everywhere except in few
" languages
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround

" In Python and Rust 4 spaces should be used instead of 2
autocmd FileType Python set softtabstop=4| set shiftwidth=4| set colorcolumn=80
autocmd FileType Rust   set softtabstop=4| set shiftwidth=4

" Use smarter indent rules for better experience. Otherwise I'd have to
set smartindent

" Show both relative line numbers and the current line number (hybrid mode)
set number
set relativenumber

" Highlight current line to improve visibility
set cursorline

" Add a vertical line to mark the line width limit so that its not exceeded
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta

" Use true colors if availible
if has('termguicolors')
  set termguicolors
endif

" Workaround NeoVim + Tmux issue (not needed in Vim):
" A hack proposed by NeoSolarized to make NoeVim + Tmux + True Colors work
" https://github.com/icymind/NeoSolarized#tmux
if has('nvim')
  set t_8f=^[[38;2;%lu;%lu;%lum
  set t_8b=^[[48;2;%lu;%lu;%lum
endif

" Start scrolling when cursor is few lines off the bound so that a reasonable
" chunk of code around selected line is visible
set scrolloff=10

" Set NeoVim cursor to the Vim default one, otherwise it shows a blinking thin
" line like in most GUI editors
if has('nvim')
  set guicursor=
endif

" Always show status
set laststatus=2

" Enable visual autocomplete menu
set wildmenu

" Only redraw when necessary so that the editor takes less resources
set lazyredraw

" Highlight matching bracket
set showmatch

" Enable incremental search
set incsearch

" Highlight chunks of text matching the search pattern
set hlsearch

" Search ignores case unless an uppercase letter appears in the pattern
set ignorecase
set smartcase

" Don't create backup files
set noswapfile
set nowritebackup

" Language-specific settings
" Always use LaTeX
let g:tex_flavor = 'latex'

" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder.
highlight ExtraWhitespace ctermbg=darkred
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
