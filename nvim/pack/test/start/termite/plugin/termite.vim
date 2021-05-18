" effectivly 2 arguments: directory & command

command! -bang -nargs=* -complete=shellcmd Termite execute(
  \ (len(<q-mods>) ? <q-mods> : 'vertical') . ' ' .
  \ 'sp term://' .
  \ (len(<q-bang>) ? fnameescape(expand('%:p:h')) : fnameescape(getcwd())) .
  \ '//' .
  \ (len(<q-args>) ? <q-args> : '$SHELL')
\)

command! -nargs=* -complete=shellcmd TermiteDir execute(
  \ (len(<q-mods>) ? <q-mods> : 'vertical') . ' ' .
  \ 'sp term://' .
  \ <q-args> .
  \ '//' .
  \ '$SHELL'
\)

nnoremap <Plug>(termite_yank_job_id) <cmd>call termite#yank_job_id()<cr>

" below should be in user space

nmap gxy <Plug>(termite_yank_job_id)
" nmap gxp <Plug>(termite_put_job_id)

nnoremap <leader>\ <cmd>vertical Termite<CR>
nnoremap <leader>- <cmd>below Termite<CR>
nnoremap <leader>\| <cmd>vertical Termite!<CR>
nnoremap <leader>_ <cmd>below Termite!<CR>

" nmap gxr <Plug>(termite_repl_open) show if hidden. toggle?
" nmap gxR <Plug>(termite_repl_new) based on filetype
" nmap gxx <Plug>(termite_repl_send)


" b:terminal_job_id
" call chansend(199, "\x1b")
" echo getbufvar(109, 'terminal_job_id')

" function of terminal pid to job/channel id
" read b/w/g of repl_job_id for send
" function to pre-process lines for repl per filetype
