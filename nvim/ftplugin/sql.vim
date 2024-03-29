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

lua require('cmp').setup.buffer({ sources = { { name = 'luasnip' }, { name = 'vim-dadbod-completion' } } })

lua << EOF
vim.api.nvim_buf_create_user_command(
  0,
  'Columns',
  function(args) require('db').get_table_columns(args.fargs[1]) end,
  { nargs = '?', desc = "Expand a * into the table's columns" }
)
EOF

lua << EOF
vim.api.nvim_buf_create_user_command(
  0,
  'GetDDL',
  function(args) require('db').get_ddl(args.fargs) end,
  { nargs = '+', desc = "Get a table's ddl" }
)
EOF

" " https://github.com/Saecki/dotfiles/blob/main/.config/nvim/lua/config/lsp/init.lua#L137-L140
" vim.lsp.handlers["textDocument/codeAction"] = function(...)
"       vim.lsp.buf.clear_references()
"       DOCUMENT_HIGHLIGHT_HANDLER(...)
"   end
