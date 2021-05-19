let g:fzf_commands_expect = 'enter,ctrl-x'

" super find
nnoremap <leader>f <cmd>Files<cr>
nnoremap <leader>F <cmd>GFiles<cr>

" super search
nnoremap <leader>/ :Rg<space>

" super search for word under cursor
nnoremap <leader>* :Rg <c-r><c-w><cr>

nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>B <cmd>BLines<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" fuzzy command list
nnoremap <leader><leader> <cmd>Commands<CR>

" override commands to add preview
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(
    \ '-co --exclude-per-directory=.gitignore',
    \ fzf#vim#with_preview(),
    \ <bang>0
  \ )

" also set Ag and Rg inside of repo, rethink these?
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'dir': FugitiveWorkTree()}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ fzf#vim#with_preview({'dir': FugitiveWorkTree()}),
    \ <bang>0
  \ )
