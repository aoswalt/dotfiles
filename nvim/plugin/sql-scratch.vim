function! ToggleSqlScratch(mods)
  let l:sql_scratch_name = get(g:, 'sql_scratch_name', '[sql_scratch]')

  let l:current_tab = tabpagenr()
  let l:page_buffers = tabpagebuflist(l:current_tab)
  let l:page_buffer_names = map(l:page_buffers, {key, val -> bufname(val)})
  let l:is_scratch_open = index(l:page_buffer_names, l:sql_scratch_name) > -1

  if l:is_scratch_open
    let l:scrach_window_number = bufwinnr(l:sql_scratch_name)
    execute l:scrach_window_number.'hide'
  else
    let l:mods = get(a:, 'mods', 'botright')
    execute l:mods 'new' '+setlocal\ buftype=nofile|setlocal\ bufhidden=hide|setlocal\ filetype=sql' l:sql_scratch_name
  endif
endfunction

command! ToggleSqlScratch :call ToggleSqlScratch(<q-mods>)

nnoremap <silent> <leader>S :ToggleSqlScratch<cr>
