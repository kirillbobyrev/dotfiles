""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom key bindings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use 'very magic' for search patterns by default.
nnoremap / /\V
nnoremap ? ?\V

" Clear highlights from the last search.
nnoremap <leader>nh :nohlsearch<cr>

" nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ga <cmd>lua vim.lsp.buf.code_action()<CR>

autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
