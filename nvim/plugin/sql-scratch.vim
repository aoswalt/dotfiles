function! ToggleSqlScratch(mods)
  " NOTE(adam): bufwinnr does a 'match' on the name, so need to escape
  let l:sql_scratch_name = get(g:, 'sql_scratch_name', '\[sql_scratch\]')

  let l:scratch_window = bufwinnr(l:sql_scratch_name)
  if l:scratch_window > -1
    execute l:scratch_window.'hide'
  else
    let l:mods = get(a:, 'mods', 'botright')
    "NOTE: more 'proper' way to create the scrat buffer
    " execute l:mods 'new' '+setlocal\ buftype=nofile|setlocal\ bufhidden=hide|setlocal\ filetype=sql' l:sql_scratch_name

    execute l:mods 'new' '+setlocal\ bufhidden=hide|setlocal\ filetype=sql' l:sql_scratch_name
    "NOTE: nofile should generally be set first, but that prevents attaching of language client
    setlocal buftype=nofile
  endif
endfunction

command! ToggleSqlScratch :call ToggleSqlScratch(<q-mods>)

nnoremap <silent> <leader>S <cmd>ToggleSqlScratch<cr>
