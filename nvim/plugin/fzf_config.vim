let g:fzf_commands_expect = 'enter,ctrl-x'

" super find
nnoremap <leader>f :GFilesPreview<CR>
nnoremap <leader>F :FZF<CR>

" super search
nnoremap <leader>/ :Rg<space>

" super search for word under cursor
nnoremap <leader>* :Rg <c-r><c-w><CR>

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>B :BLines<cr>

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
nnoremap <leader><leader> :Commands<CR>

" override Ag and Rg commands to search inside git repo and add preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'dir': FugitiveWorkTree()}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ fzf#vim#with_preview({'dir': FugitiveWorkTree()}),
    \ <bang>0
  \ )

" new GFiles to add preview
command! -bang -nargs=? GFilesPreview
    \ call fzf#vim#gitfiles(
    \ '-co --exclude-per-directory=.gitignore',
    \ fzf#vim#with_preview(),
    \ <bang>0
  \ )

