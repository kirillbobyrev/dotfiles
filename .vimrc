""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO(omtcvxyz): get through docs, personalize some plugins.
call plug#begin('~/.vim/plugged')
" Install Plugins
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'

" TODO(omtcvxyz): It's probably better to use lightline since it looks
" cleaner, but at the moment AFAIK there is no gruvbox theme for it, I might
" want to check whether it appears in the future or build it up myself.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'rhysd/vim-clang-format', { 'for': ['cpp', 'c'] }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

Plug 'llvm-mirror/llvm', { 'rtp': 'utils/vim', 'for': 'llvm' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --system-boost --racer-completer', 'for': ['cpp', 'c', 'python', 'rust']}
Plug 'w0rp/ale'
call plug#end()

" Plugin-specific settings

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" vim-clang-format
let g:clang_format#code_style = 'llvm'

" UltiSnips
" TODO(omtcvxyz): Figure out what to do when both YCM completion shows up and
" UltiSnip snippet can be triggered. Pressing the expand trigger doesn't work.
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
let g:ale_cpp_clangtidy_checks = ['performance*', 'modernize*', 'bugprone*']
" Always show sign column so that when warnings appear the text is not shifted
let g:ale_sign_column_always = 1

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}

" Gruvbox colorscheme
" Always use italics regardless of GUI being disabled.
let g:gruvbox_italic = 1
set background=dark
colorscheme gruvbox

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use the plugin to remove trailing whitespaces upon
" saving the file.
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
highlight ExtraWhitespace ctermbg=darkred

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

" Add a vertical line to mark the line width limit so that its not exceeded.
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta

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
