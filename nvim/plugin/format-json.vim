" format a block of JSON with python's built-in function
" supplanted by json filetype formatter / lsp?
function! FormatJSON() range
  let l:fullRange = a:firstline.','.a:lastline
  let l:singeLine = a:firstline.','.a:firstline
  silent exe l:fullRange.'join | '.l:singeLine.'! python3 -m "json.tool"'
  silent normal =}
endfunction

command! -range FormatJSON :<line1>,<line2>call FormatJSON()
