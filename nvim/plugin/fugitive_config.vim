command! -range GlogRange execute('Git --paginate log -L' . <line1> . ',' . <line2> . ':%')

nnoremap <leader>gs <cmd>Git<cr>
nnoremap <leader>ga <cmd>Gwrite<cr>
nnoremap <leader>gb <cmd>Git blame<cr>
nnoremap <leader>gc <cmd>Git commit -v<cr>
nnoremap <leader>gd <cmd>Gdiffsplit<cr>
nnoremap <leader>gl <cmd>Git --paginate log<cr>
vnoremap <leader>gl <cmd>GlogRange<cr>
nnoremap <leader>gL <cmd>Git --paginate log -p %<cr>
vnoremap <leader>gL <cmd>GlogRange<cr>
nnoremap <leader>gr <cmd>Git rebase -i --autosquash<cr>

" git push and fetch using Dispatch - :Dispatch git push
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
\ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
\ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

command! -nargs=* Gpushf execute('Gpush --force-with-lease '.<q-args>)

command! -nargs=* Gpc execute('Gpush --set-upstream origin '.FugitiveHead().' '.<q-args>)

" amend without editing commit message
command! Gamend Git commit --amend --no-edit
