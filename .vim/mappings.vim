""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom key bindings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga).
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip).
nnoremap ga <Plug>(EasyAlign)

" Make it easier to configure the editor on the fly.
nnoremap <leader>ev :tabedit $HOME/.vim/vimrc<cr>
nnoremap <leader>em :tabedit $HOME/.vim/mappings.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Trigger NERDTree for all tabs.
nnoremap <leader>nt :NERDTreeTabsToggle<cr>

" Clear highlights from the last search.
nnoremap <leader>nh :nohlsearch

" Use 'very magic' for search patterns by default.
nnoremap / /\v
nnoremap ? ?\v

" coc.nvim bindings -------------------------------------------------------- {{{

" Use tab for trigger completion with characters ahead and navigate.  Use
" command ':verbose imap <tab>' to make sure tab is not mapped by other.
" plugin.
imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
imap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nmap <silent> K :call <SID>ShowDocumentation()<CR>

function! s:ShowDocumentation()
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

" Remap for do codeAction of selected region, ex: `<leader>aap` for current
" paragraph.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature
" of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like:
" coc-tsserver, coc-python.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nmap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nmap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nmap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nmap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nmap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nmap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nmap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nmap <silent> <space>p  :<C-u>CocListResume<CR>

function! s:ClangdSwitchHeaderSource()
    let l:alter = CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
    " remove file:/// from response
    let l:alter = substitute(l:alter, "file://", "", "")
    execute 'edit ' . l:alter
endfunction

" TODO: Move this to $HOME . /.vim/after/ftplugin/cpp.vim
" TODO: Add mapping to open header/source in a new split/tab.
autocmd FileType cpp nnoremap <leader>ss :call <SID>ClangdSwitchHeaderSource()<CR>

" }}}
