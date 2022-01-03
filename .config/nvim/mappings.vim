""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom key bindings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Avoid using Escape key.

" Use 'very magic' for search patterns by default.
nnoremap / /\V
nnoremap ? ?\V

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga).
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip).
nnoremap ga <Plug>(EasyAlign)

" Make it easier to configure the editor on the fly.
nnoremap <leader>ev :tabedit $HOME/.config/nvim/init.lua<cr>
nnoremap <leader>em :tabedit $HOME/.config/nvim/mappings.vim<cr>
nnoremap <leader>ep :tabedit $HOME/.config/nvim/lua/plugins.lua<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Trigger NERDTree for all tabs.
nnoremap <leader>nt :NERDTreeTabsToggle<cr>

" Clear highlights from the last search.
nnoremap <leader>nh :nohlsearch<cr>
