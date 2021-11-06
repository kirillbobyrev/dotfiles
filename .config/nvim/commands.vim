""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Format` command to format current buffer.
command! -nargs=0 LSPLogs :CocCommand workspace.showOutput
