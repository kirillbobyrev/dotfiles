" General settings {{{
" Always use UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf8
" Use Unix line endings
set fileformats=unix
" Start scrolling when cursor is few lines off the bound so that a reasonable
" chunk of code around selected line is visible
set scrolloff=10
" Enable filetype plugin
filetype plugin indent on
" Always check spelling to improve grammar and prevent typos
set spell spelllang=en_us
" Use smarter indent rules for better experience
set smartindent
" Set NeoVim cursor to the Vim default one, otherwise it shows a blinking thin
" line like in most GUI editors
set guicursor=
" Always show status
set laststatus=2
" Show both relative line numbers and the current line number (hybrid mode)
set number
set relativenumber
" Display useful info like line number and relative position display on bottom
if !has('ruler')
  set ruler
endif
" Highlight current line to improve visibility
set cursorline
" Add a vertical line to mark the line width limit so that its not exceeded
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta
" Enable visual autocomplete menu
set wildmenu
" Only redraw when necessary so that the editor takes less resources
set lazyredraw
" Highlight matching bracket
set showmatch
" }}}
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
let g:tex_flavor = 'latex'
" }}}
" Plugins configuration {{{
" Vim-Plug directives {{{
" Initialize plugin system
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
" Install Plugins
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
Plug 'iCyMind/NeoSolarized'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
" The following section contains NeoVim-specific plugins which rely on
" additional features, NeoVim async model and so on.
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'zchee/deoplete-clang'
  Plug 'zchee/deoplete-jedi'
endif
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
" ale {{{
" TODO(omtcvxyz): For now, probably whitelist trusted linters, otherwise ale
" is quite slow.
" For the future, blacklist untrusted ones:
" https://github.com/w0rp/ale/issues/1453
let g:ale_cpp_clangtidy_checks = ['performance-*', 'modernize-*']
let g:ale_sign_column_always = 1
" }}}
" Snippets {{{
" Trigger configuration.
" TODO(omtcvxyz): Think of a better hotkeys.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir = '~/.config/snippets'
" }}}
" Vimtex {{{
let g:vimtex_compiler_latexmk = {'callback' : 0}
" }}}
" Vim-Airline {{{
let g:airline_theme = 'solarized'
" }}}
" Solarized colorscheme {{{
" Enable solarized colorscheme after its initialization via vim-plug
let g:neosolarized_italic = 1
set background=dark
colorscheme NeoSolarized
" }}}
" }}}
" Highlight trailing whitespace {{{
" While this probably belongs to UI it has to come after plugins
" configuration, because vim-colors-solarized would prevent extra whitespace
" highlight.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
" }}}
" vim:foldmethod=marker:foldlevel=0
