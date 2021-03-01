nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gc :Git commit -v<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gl :Git --paginate log<cr>
nnoremap <leader>gL :Git --paginate log -p %<cr>
nnoremap <leader>gr :Git rebase -i --autosquash

" git push and fetch using Dispatch - :Dispatch git push
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
  \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
  \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

command! -nargs=* Gpc execute('Gpush --set-upstream origin '.FugitiveHead().' '.<q-args>)

" amend without editing commit message
command! Gamend Git commit --amend --no-edit
