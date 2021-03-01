" search for visual selection -  from practical vim
function! s:VSetSearch(cmdType)
  let l:temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdType.'\'), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>

" =====
" this is basically the opposite. combine vs separate file?

" search within range, see *search-range*
vnoremap g/ <esc>/\%><c-r>=line("'<")-1<cr>l\%<<c-r>=line("'>")+1<cr>l
vnoremap g? <esc>?\%><c-r>=line("'<")-1<cr>l\%<<c-r>=line("'>")+1<cr>l
