syntax on
set number
set incsearch
set hlsearch
set ignorecase
set smartcase
set nocompatible
set ruler
set showcmd
set foldenable
set noerrorbells visualbell t_vb=
set mouse=a
set mousemodel=popup
set autoindent
set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
set colorcolumn=81
set laststatus=2
set encoding=utf-8
highlight ColorColumn ctermbg=darkgray
autocmd FileType python set softtabstop=4| set shiftwidth=4| set shiftwidth=4|
                      \ set textwidth=79| set expandtab| set autoindent|
                      \ set fileformat=unix
autocmd FileType rust set colorcolumn=101

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'nvie/vim-flake8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
