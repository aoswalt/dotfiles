" swap ; and :
noremap ; :
noremap : ;

" pretty much always want very magic searches
nnoremap / /\v
nnoremap ? ?\v
cnoremap %s/ %s/\v

" move cursor into wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj

" use Q to play q macro
nnoremap Q @q

" run 'q' macro on selection
xnoremap Q <cmd>normal @q<cr>

" allow range commands from searches - ex:  /foo$m
cnoremap $t <cr>:t''<cr>
cnoremap $m <cr>:m''<cr>
cnoremap $d <cr>:d<cr>``

" reselect pasted content:
noremap gV `[v`]

" buffer management
nnoremap <c-up> :ls<cr>:b
nnoremap <c-right> <cmd>bn<cr>
nnoremap <c-left> <cmd>bp<cr>
nnoremap <c-down> <cmd>bn \| bd #<cr>

nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>
nnoremap <leader>Q <cmd>bd<cr>

" easier previous buffer because c-s-6 is cumbersome
nnoremap <BS> <c-^>

" system clipboard yank
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>d "+d
vnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>D "+D

" put searches in middle of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
xmap n nzz
xmap N Nzz
" xmap * *zz " not being recursive as expected with visual-search.vim
" xmap # #zz
nmap g* g*zz
nmap g# g#zz

map <c-ScrollWheelUp> zh
map <c-ScrollWheelDown> zl
map <c-s-ScrollWheelUp> zH
map <c-s-ScrollWheelDown> zL

" inside template tags (<%= foo %>)
onoremap <silent> iT <cmd>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
xnoremap <silent> iT <cmd>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
onoremap <silent> aT <cmd>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>
xnoremap <silent> aT <cmd>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>

" should try using gq for formatting
nnoremap <silent> <f4> <cmd>Format<cr>
vnoremap <silent> <f4> :Format<cr>
