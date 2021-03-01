function! DiffLineWithNext()
  let f1=tempname()
  let f2=tempname()

  exec ".write " . f1
  exec ".+1write " . f2

  exec "tabedit " . f1
  exec "vert diffsplit " . f2
endfunction
