""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++-specific settings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: Add mapping to open header/source in a new split/tab.
nnoremap <buffer> <leader>ss :CocCommand clangd.switchSourceHeader vsplit<CR>
