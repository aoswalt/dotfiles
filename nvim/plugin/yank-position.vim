function! YankPosition(...)
  let l:register = get(a:, 1, 0)

  if trim(l:register) == ''
    let l:register = '"'
  endif

  let l:fileLine = expand('%') . ':' . line('.') . ':' . col('.')

  execute 'let @' . l:register . ' = "' . l:fileLine . '"'
endfunction

command! -nargs=? YankPosition :call YankPosition(<q-args>)
