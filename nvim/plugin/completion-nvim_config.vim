let g:completion_auto_change_source = 1

let g:completion_enable_snippet = 'snippets.nvim'

let g:completion_confirm_key = ""
imap <expr> <tab>  pumvisible() && complete_info()["selected"] != "-1"
  \ ? "\<Plug>(completion_confirm_completion)"
  \ : "\<tab>"

" enable completion even for non lsp
autocmd BufEnter * lua require'completion'.on_attach()

imap <c-h> <Plug>(completion_prev_source)
imap <c-l> <Plug>(completion_next_source)

let g:completion_chain_complete_list = {
\   'default':{
\     'comment': [
\       {'mode': '<c-n>'},
\     ],
\     'default': [
\       {'complete_items': ['lsp', 'snippet']},
\       {'mode': '<c-n>'}
\     ]
\   }
\ }
