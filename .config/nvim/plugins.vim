""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation ------------------------------------------------------------- {{{

" TODO: Figure out what causes the comment to continue AND bundles backspace
" with the next line when writing right after the comment.
" TODO: Get through all plugins, read docs and customize them.
call plug#begin(stdpath('data') .. '/plugged')

Plug 'Shirk/vim-gas'
Plug 'Yggdroot/indentLine'
Plug 'dstein64/vim-startuptime'
Plug 'dyng/ctrlsf.vim'
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
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'liuchengxu/vista.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'llvm-mirror/llvm', { 'rtp': 'utils/vim', 'for': 'llvm' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

" IMPORTANT: This has to be the last one.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

" Plugins customization ---------------------------------------------------- {{{

" UltiSnips
" TODO: Manage coc.nvim integration.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME .. '/.config/UltiSnips']

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" lightline.vim
" TODO: Customize lightline more. Ideas:
" * Use full path to the file in lightline.
" * Take a look at example configurations of lightline.
" * Take a look at configurations of powerline, airline, etc.
function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype .. ' ' .. WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat .. ' ' .. WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Add diagnostic info for lightline.vim
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" Always prefer LaTeX over plain TeX.
let g:tex_flavor = 'latex'

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use this plugin to remove trailing whitespaces upon
" saving the file.
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
augroup comments_highlight
  autocmd!
  highlight ExtraWhitespace ctermbg=DarkMagenta
augroup END

" vim-startify
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ..' '.. entry_path'
endfunction

" NERD commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" indentLine
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

" sneak
let g:sneak#s_next = 1

" coc.nvim ----------------------------------------------------------------- {{{

" Give more space for the messages.
set cmdheight=2

" Unify CoC.nvim config across NeoVim and Vim.
let g:coc_config_home = $HOME .. '/.config/coc'

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" }}}

" }}}
