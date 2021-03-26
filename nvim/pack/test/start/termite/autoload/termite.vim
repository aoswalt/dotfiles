function! s:throw(string) abort
  throw 'termite: '.a:string
endfunction

function! termite#yank_job_id(register = v:register) abort
  if empty(get(b:, 'terminal_job_id'))
    throw('No terminal job id found in buffer')
  endif

  call setreg(a:register, b:terminal_job_id)
endfunction
