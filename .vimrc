syntax enable
set number
set incsearch
set hlsearch
set ignorecase
set smartcase
set nocompatible
set autoindent
set smartindent
set ruler
set colorcolumn=81

set softtabstop=2
set shiftwidth=2
set encoding=utf-8

highlight ColorColumn ctermbg=darkgray

autocmd FileType python set softtabstop=4| set shiftwidth=4|
                      \ set textwidth=79| set expandtab| set autoindent|
                      \ set fileformat=unix

noremap <leader>cf :pyf /home/omtcyfz/dev/src/llvm/tools/clang/tools/clang-format/clang-format.py<cr>

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
call plug#end()
