nnoremap <buffer> <silent> K :DB \h <c-r><c-w><cr>

" TODO(adam): use Dispatch to default these?
nnoremap <buffer> <leader>rr :.DB<cr>
nmap <buffer> <expr> <leader>r db#op_exec()
vmap <buffer> <expr> <leader>r db#op_exec()

nnoremap <buffer> gss :.DB<cr>
nmap <buffer> <expr> gs db#op_exec()
vmap <buffer> <expr> gs db#op_exec()

" TODO(adam): is integration with psql repl possible/feasible?
nnoremap <buffer> gxx :.DB<cr>
nmap <buffer> <expr> gx db#op_exec()
vmap <buffer> <expr> gx db#op_exec()

" nnoremap <buffer> <c-q><c-q> :.DB<cr>
" nmap <buffer> <expr> <c-q> db#op_exec()
" vmap <buffer> <expr> <c-q> db#op_exec()
