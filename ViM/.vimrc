" VUNDLE 

set nocompatible	" be iMproved
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'davidhalter/jedi-vim'             " Python autocomletion
Plugin 'scrooloose/nerdtree'              " File navigation
Plugin 'bling/vim-airline'                " Fancy panels for ViM
Plugin 'plasticboy/vim-markdown.git'      " Markdown format support
Plugin 'jiangmiao/auto-pairs'             " Closing braces and stuff
Plugin 'tpope/vim-fugitive'               " the best Git wrapper of all time
Plugin 'majutsushi/tagbar'                " an easy way to browse the tags
Plugin 'scrooloose/syntastic'             " syntax checking plugin

call vundle#end()       
filetype plugin indent on

" NERDTree
let NERDTreeIgnore=['\.pyc$']
map <C-n> :NERDTreeToggle<CR>

" Airline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs"

" Other ...

" Syntax highlighting enables.
if has("syntax")
  syntax on
endif

set smartcase	" Do smart case matching
set autowrite	" Automatically save before commands like :next and :make

" size of a hard tabstop
set tabstop=2

" size of an indent
set shiftwidth=2

" use spaces instead of tabs
set expandtab

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

" show the colorcolumn, so that the 80 chars per line limit is visible
set colorcolumn=81

" show the line numbers
set number

" set the textwidth to be 80 anyway
set textwidth=80

" this is for the colorschemes
set t_Co=256
