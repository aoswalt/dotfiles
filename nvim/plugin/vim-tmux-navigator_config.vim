let g:tmux_navigator_no_mappings = 1

" split navigation
nnoremap <silent> <m-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <m-k> <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <m-l> <cmd>TmuxNavigateRight<cr>
nnoremap <silent> <m-\> <cmd>TmuxNavigatePrevious<cr>
inoremap <silent> <m-h> <esc><cmd>TmuxNavigateLeft<cr>
inoremap <silent> <m-j> <esc><cmd>TmuxNavigateDown<cr>
inoremap <silent> <m-k> <esc><cmd>TmuxNavigateUp<cr>
inoremap <silent> <m-l> <esc><cmd>TmuxNavigateRight<cr>
