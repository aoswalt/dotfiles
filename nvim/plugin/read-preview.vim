function! ReadPreview() abort
  if &previewwindow     " don't do this in the preview window
    echo "Can't read inside preview window"
    return
  endif

  silent! wincmd P " to preview window

  if &previewwindow == 0 " couldn't get to preview window
    echo "No preview window open"
    return
  endif

  let l:contents = getline(1, "$")
  wincmd p      " back to old window

  put =l:contents
endfunction

command! ReadPreview call ReadPreview()

nnoremap <silent> <leader>Rp :ReadPreview<cr>
