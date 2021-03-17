" run macro on selection
function! g:ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ <cmd>call ExecuteMacroOverVisualRange()<CR>
