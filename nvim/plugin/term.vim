autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide sidescrolloff=0

" augroup term_insert
"   " go into insert mode if switching to a terminal buffer
"   autocmd BufEnter term://* startinsert
"   autocmd BufLeave term://* stopinsert
" augroup end

" more convenient escape
tnoremap <leader><esc> <c-\><c-n>

" split navigation
tnoremap <m-[> <c-\><c-n>
tnoremap <m-h> <c-\><c-n><c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l

" open a terminal in a different view
command! -nargs=* VTerm :vsp
  \ | execute 'lcd' expand('%:h')
  \ | execute 'terminal' <q-args>
command! -nargs=* VTermRepo :vsp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <q-args>
command! -nargs=* STerm :sp
  \ | execute 'lcd' expand('%:h')
  \ | execute 'terminal' <q-args>
command! -nargs=* STermRepo :sp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <q-args>
command! -nargs=* TTerm :tabnew
  \ | execute 'lcd' expand('%:h')
  \ | execute 'terminal' <q-args>
command! -nargs=* TTermRepo :tabedit
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <q-args>

" term splits
" nnoremap <leader>\ <cmd>VTerm<CR>
" nnoremap <leader>- <cmd>STerm<CR>
" nnoremap <leader>\| <cmd>VTermRepo<CR>
" nnoremap <leader>_ <cmd>STermRepo<CR>
