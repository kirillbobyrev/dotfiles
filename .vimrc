syntax enable
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

autocmd FileType python set softtabstop=4| set shiftwidth=4|
                      \ set textwidth=79| set expandtab| set autoindent|
                      \ set fileformat=unix

noremap <leader>cf :pyf /home/omtcyfz/dev/src/llvm/tools/clang/tools/clang-format/clang-format.py<cr>
noremap <leader>cr :pyf /home/omtcyfz/dev/src/llvm/tools/clang/tools/extra/clang-rename/tool/clang-rename.py<cr>

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
call plug#end()
