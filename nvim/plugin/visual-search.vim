" search for visual selection -  from practical vim
function! s:VSetSearch(cmdType)
  let l:temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdType.'\'), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

xnoremap * :<c-u>call <SID>VSetSearch('/')<cr>/<C-R>=@/<cr><cr>
xnoremap # :<c-u>call <SID>VSetSearch('?')<cr>/<C-R>=@/<cr><cr>

" =====
" this is basically the opposite. combine vs separate file?

" search within range, see *search-range*
vnoremap g/ <esc>/\%><c-r>=line("'<")-1<cr>l\%<<c-r>=line("'>")+1<cr>l
vnoremap g? <esc>?\%><c-r>=line("'<")-1<cr>l\%<<c-r>=line("'>")+1<cr>l
