" General settings {{{
" Always use UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf8
" Use Unix line endings
set fileformats=unix
" Start scrolling when cursor is 4 lines off the bound
set scrolloff=4
" Enable filetype plugin
filetype plugin indent on
" Always check spelling since I often do typos
set spell spelllang=en_us
" Indent after brackets, etc
set smartindent
" }}}
" UI {{{
" NeoVim cursor
set guicursor=
" Always show status
set laststatus=2
" Show relative line numbers and the current line number (hybrid mode)
set number
set relativenumber
if !has('nvim')
  " Show line number, etc on bottom
  set ruler
endif
" Highlight current line
set cursorline
" Add a vertical line to mark the line width limit
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta
" Enable visual autocomplete menu
set wildmenu
" Do not redraw when unnecessary
set lazyredraw
" Highlight matching bracket
set showmatch
" Searching {{{
" Enable incremental search
set incsearch
" Highlight chunks of text matching the search pattern
set hlsearch
" Search ignores case unless an uppercase letter appears in the pattern
set ignorecase
set smartcase
" }}}
" Backup {{{
" Don't create backup files
set noswapfile
set nowritebackup
" }}}
" Spaces & Tabs {{{
" Always prefer spaces over tabs, use 2 spaces everywhere except in few
" languages
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround
" }}}
" Custom commands & functions {{{
" Autoformat selected code using Clang-format
noremap <leader>cf :pyf /home/omtcvxyz/dev/projects/src/llvm/tools/clang/tools/clang-format/clang-format.py<cr>
" }}}
" Language-specific settings {{{
" In Python and Rust 4 spaces should be used instead of 2
autocmd FileType Python set softtabstop=4| set shiftwidth=4| set colorcolumn=80
autocmd FileType Rust   set softtabstop=4| set shiftwidth=4
" Always use LaTeX
let g:tex_flavor='latex'
" }}}
" }}}
" Plugins configuration {{{
" Vim-Plug directives {{{
" Initialize plugin system
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-clang'
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'zchee/deoplete-jedi'
endif
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'omtcvxyz/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" }}}
" Plugins-specific settings {{{
" Deoplete & friends {{{
if has('nvim')
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
  let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/6.0.0/include/'

  let g:deoplete#sources#rust#racer_binary = '/home/omtcvxyz/.cargo/bin/racer'
  let g:deoplete#sources#rust#rust_source_path = '/home/omtcvxyz/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
endif
" }}}
" Vimtex {{{
let g:vimtex_compiler_latexmk = {'callback' : 0}
" }}}
" Vim-Airline {{{
let g:airline_theme='solarized'
" }}}
" vim-colors-solarized {{{
" Enable solarized colorscheme after its initialization via vim-plug
set background=dark
colorscheme solarized
" }}}
" }}}
" Highlight trailing whitespace {{{
" This has to come after plugins configuration, because vim-colors-solarized
" would prevent extra whitespace highlight otherwise.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
" }}}
" vim:foldmethod=marker:foldlevel=0
