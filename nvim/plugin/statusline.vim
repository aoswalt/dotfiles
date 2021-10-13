function! ExpandedFilename()
  let l:filename = expand('%')
  return len(l:filename) > 0 ? l:filename : '[No Name]'
endfunction

let g:lightline = {
\   'component': {
\     'readonly': '%{&readonly?"\ue0a2":""}',
\   },
\   'component_function': {
\     'filename': 'ExpandedFilename',
\     'gitversion': 'GitVersion'
\   },
\   'active': {
\     'right': [
\        [ 'lineinfo'],
\        [ 'gitversion', 'percent' ],
\        [ 'fileformat', 'filetype' ],
\     ]
\   },
\   'inactive': {
\     'right': [
\        [ 'lineinfo' ],
\        [ 'gitversion', 'percent' ],
\     ]
\   },
\ }

function! GitVersion()
  let l:fullname = expand('%')
  let l:gitversion = ''

  if l:fullname =~? 'fugitive://.*/\.git//0/.*'
    let l:gitversion = 'git index'
  elseif l:fullname =~? 'fugitive://.*/\.git//2/.*'
    let l:gitversion = 'git target'
  elseif l:fullname =~? 'fugitive://.*/\.git//3/.*'
    let l:gitversion = 'git merge'
  elseif &diff == 1
    let l:gitversion = 'working copy'
  endif

  return l:gitversion
endfunction
