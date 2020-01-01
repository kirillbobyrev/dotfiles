""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: Figure out what causes the comment to continue AND bundles backspace
" with the next line when writing right after the comment.
" TODO: Get through all plugins, read docs and customize them.
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shirk/vim-gas'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'lifepillar/vim-cheat40'
Plug 'liuchengxu/vim-which-key'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim/killersheep'
Plug 'wellle/targets.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'llvm-mirror/llvm', { 'rtp': 'utils/vim', 'for': 'llvm' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

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

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" Always prefer LaTeX over plain TeX.
let g:tex_flavor = 'latex'

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use this plugin to remove trailing whitespaces upon
" saving the file.
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
augroup CommentsHighlight
  autocmd!
  highlight ExtraWhitespace ctermbg=DarkMagenta
augroup END

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
