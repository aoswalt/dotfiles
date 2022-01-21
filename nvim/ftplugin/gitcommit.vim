nnoremap <buffer> <leader># <cmd>exec 'Telescope gh issues assignee=' . trim(system('git config user.email'))<cr>
