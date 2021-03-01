" show highlight stack
" should show transparent groups
" https://github.com/b0o/vim-HiLinkTrace/blob/343b5a51cd15f167dff97df0587376ba2e4d52f6/plugin/hilinks.vim#L77
function! SynStack()
  let l:syns = synstack(line('.'), col('.'))
  call map(l:syns, {key, item -> [synIDattr(item, 'name'), synIDattr(synIDtrans(item), 'name')]})
  call map(l:syns, {key, pair -> ('[' . get(pair, 0) . '->' . get(pair, 1) . ']')})
  echo join(l:syns, ' => ')
endfunction

command! SynStack :call SynStack()
