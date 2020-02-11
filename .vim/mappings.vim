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
