""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: Get through all plugins, read docs and customize them.
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shirk/vim-gas'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'lifepillar/vim-cheat40'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'llvm-mirror/llvm', { 'rtp': 'utils/vim', 'for': 'llvm' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

" IMPORTANT: This has to be the last one.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Plugin-specific settings

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/UltiSnips']

" lightline.vim
" TODO: Customize lightline more. Ideas:
" * Use full path to the file in lightline.
" * Take a look at example configurations of lightline.
" * Take a look at configurations of powerline, airline, etc.
if has('nvim')
  function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! LightLineFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction

  " Add diagnostic info for https://github.com/itchyny/lightline.vim
  let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ }
endif

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" Always use LaTeX
let g:tex_flavor = 'latex'

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use the plugin to remove trailing whitespaces upon
" saving the file.
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
augroup CommentsHighlight
  autocmd!
  highlight ExtraWhitespace ctermbg=DarkMagenta
augroup END

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-startify
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

" NERD commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always use UTF-8 encoding.
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf8

" Use Unix line endings.
set fileformats=unix

" Use smarter indent rules for better experience.
set autoindent
" Enable filetype plugin.
filetype plugin indent on

" Always check spelling to improve grammar and prevent typos.
set spelllang=en_us
set spell

" Gruvbox colorscheme
" TODO: Find a neat way to get around italics being disabled in
" Alacritty (despite being supported) and the strange hack of checking
" $TERM_ITALICS in Gruvbox repo. Probably, some .terminfo should be utilized.
let g:gruvbox_italic = 1
let g:gruvbox_guisp_fallback = 'bg'
set background=dark
colorscheme gruvbox

" Spaces & Tabs
" Always prefer spaces over tabs, use 2 spaces everywhere except in few
" languages.
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround

" Proper backspace behavior.
set backspace=indent,eol,start

augroup Python
  autocmd!
  autocmd FileType python set softtabstop=4| set shiftwidth=4
  autocmd FileType python set colorcolumn=80
augroup END

augroup Go
  autocmd!
  autocmd FileType go set expandtab!
  autocmd FileType go set tabstop=4
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set shiftround!
augroup END

" Add a vertical line to mark the line width limit so that its not exceeded.
set colorcolumn=81
highlight ColorColumn ctermbg=DarkMagenta guibg=#ED2939

" Show both relative line numbers and the current line number (hybrid mode).
" This way it's easier to move around and do motions.
set number
set relativenumber

" Highlight current line to improve visibility.
set cursorline

if !has('nvim') && !has('termguicolors')
  set t_Co=256
endif
" Use true colors if available (in NeoVim). Set `termguicolors` for that.
if has('termguicolors')
  set termguicolors
  " Use a hack proposed in https://github.com/icymind/NeoSolarized#tmux to make
  " Vim + True Colors + Tmux work better.
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
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

" Redraw faster
set ttyfast

" Highlight matching bracket.
set showmatch

" Enable incremental search.
set incsearch
" Highlight chunks of text matching the search pattern.
set hlsearch
" Search ignores case unless an uppercase letter appears in the pattern.
set ignorecase
set smartcase
" Use magic for regular expressions
set magic

" Don't create backup files.
set noswapfile
set nowritebackup

" Opens signcolumn by default.
set signcolumn=yes

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoVim specifics
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set NeoVim cursor to the Vim default one, otherwise it shows a blinking thin
" line like in most GUI editors
set guicursor=
