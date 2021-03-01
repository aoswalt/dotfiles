let g:completion_auto_change_source = 1

let g:completion_enable_snippet = 'snippets.nvim'

let g:completion_confirm_key = ""
imap <expr> <tab>  pumvisible() && complete_info()["selected"] != "-1"
  \ ? "\<Plug>(completion_confirm_completion)"
  \ : "\<tab>"

" enable completion even for non lsp
autocmd BufEnter * lua require'completion'.on_attach()
