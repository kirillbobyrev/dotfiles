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

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'llvm-mirror/llvm', { 'rtp': 'utils/vim', 'for': 'llvm' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }

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
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
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
" LSP Configuration (coc.nvim)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
