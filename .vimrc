""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO(omtcvxyz): get through docs, personalize some plugins.
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'justinmk/vim-sneak'
Plug 'vimwiki/vimwiki'

Plug 'itchyny/lightline.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'rhysd/vim-clang-format', { 'for': ['cpp', 'c'] }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
call plug#end()

" Plugin-specific settings

" vim-clang-format
let g:clang_format#code_style = 'llvm'

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}

" Gruvbox colorscheme
" TODO(omtcvxyz): Find a neat way to get around italics being disabled in
" Alacritty (despite being supported) and the strange hack of checking
" $TERM_ITALICS in Gruvbox repo. Probably, some .terminfo should be utilized.
" let g:gruvbox_italic = 1
set background=dark
colorscheme gruvbox

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use the plugin to remove trailing whitespaces upon
" saving the file.
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
highlight ExtraWhitespace ctermbg=DarkMagenta

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always use UTF-8 encoding.
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf8

" Use Unix line endings.
set fileformats=unix

" Enable filetype plugin.
filetype plugin indent on

" Always check spelling to improve grammar and prevent typos.
set spell spelllang=en_us

" Spaces & Tabs
" Always prefer spaces over tabs, use 2 spaces everywhere except in few
" languages.
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround

" Add a vertical line to mark the line width limit so that its not exceeded.
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta

" In Python and Rust 4 spaces should be used instead of 2.
autocmd FileType Rust   set softtabstop=4| set shiftwidth=4
" Also, in Python the widthlimit should be 79 and not 80 like everywhere else.
autocmd FileType Python set softtabstop=4| set shiftwidth=4| set colorcolumn=80

" Use smarter indent rules for better experience.
set autoindent

" Show both relative line numbers and the current line number (hybrid mode).
" This way it's easier to move around and do motions.
set number
set relativenumber

" Highlight current line to improve visibility.
set cursorline

" Use true colors if availible, for that `termguicolors` are needed.
if has('termguicolors')
  set termguicolors
endif

" Start scrolling when cursor is few lines off the bound so that a reasonable
" chunk of code around selected line is visible.
set scrolloff=10

" Always show status.
set laststatus=2

" Enable visual autocomplete menu.
set wildmenu

" Only redraw when necessary so that the editor takes less resources.
set lazyredraw

" Highlight matching bracket.
set showmatch

" Enable incremental search.
set incsearch
" Highlight chunks of text matching the search pattern.
set hlsearch
" Search ignores case unless an uppercase letter appears in the pattern.
set ignorecase
set smartcase

" Don't create backup files.
set noswapfile
set nowritebackup

" Always use LaTeX
let g:tex_flavor = 'latex'

" Use more colors
set t_Co=256
" Use a hack proposed in https://github.com/icymind/NeoSolarized#tmux to make
" Vim + True Colors + Tmux work better.
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
