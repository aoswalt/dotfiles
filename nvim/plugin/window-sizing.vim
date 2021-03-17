function! MaximizeWindow()
  vertical resize
  resize
endfunction

let s:maximized=0
function! ZoomToggle()
  if s:maximized
    wincmd =
    let s:maximized=0
  else
    call MaximizeWindow()
    let s:maximized=1
  endif
endfunction

" window resizing
nnoremap <M-S-h> <C-w><
nnoremap <M-S-j> <C-w>+
nnoremap <M-S-k> <C-w>-
nnoremap <M-S-l> <C-w>>
nnoremap <silent> <M-=> <c-w>=
nnoremap <silent> <M-'> <cmd>call ZoomToggle()<cr>
nnoremap <silent> <M-z> <cmd>call MaximizeWindow()<cr>
