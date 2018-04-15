""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO(omtcvxyz): Improve LLVM IR editing experience by figuring out how to
" reuse https://github.com/llvm-mirror/llvm/blob/master/utils/vim in the best
" possible way.
" TODO(omtcvxyz): get through docs, personalize some plugins.
call plug#begin('~/.vim/plugged')
" Install Plugins
Plug 'rhysd/vim-clang-format'
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'lervag/vimtex'

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'rust-lang/rust.vim'

Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --system-boost --racer-completer' }
call plug#end()

" Plugins-specific settings

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" vim-clang-format
let g:clang_format#code_style = 'llvm'

" UltiSnips
" TODO(omtcvxyz): think of a better hotkey. C-j is not really great.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

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
set termguicolors

" Start scrolling when cursor is few lines off the bound so that a reasonable
" chunk of code around selected line is visible
set scrolloff=10

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
