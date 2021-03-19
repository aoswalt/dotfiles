nnoremap <buffer> <silent> K <cmd>DB \h <c-r><c-w><cr>

" TODO(adam): use Dispatch to default these?
nnoremap <buffer> <leader>rr <cmd>.DB<cr>
nmap <buffer> <expr> <leader>r db#op_exec()
vmap <buffer> <expr> <leader>r db#op_exec()

nnoremap <buffer> gss <cmd>.DB<cr>
nmap <buffer> <expr> gs db#op_exec()
vmap <buffer> <expr> gs db#op_exec()

" TODO(adam): piggyback on repl mappings to add trailing ; if needed?

" nnoremap <buffer> <c-q><c-q> <cmd>.DB<cr>
" nmap <buffer> <expr> <c-q> db#op_exec()
" vmap <buffer> <expr> <c-q> db#op_exec()
