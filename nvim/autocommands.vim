autocmd TextYankPost * silent! lua vim.highlight.on_yank{timeout = 300}

" only show cursor line in active window
augroup cursorLine
  autocmd!
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
augroup end
