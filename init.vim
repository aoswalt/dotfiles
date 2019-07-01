scriptencoding utf-8

" install plug if not found {{{1
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    autocmd VimEnter * PlugInstall
  augroup end
endif

" plugins {{{1
call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'

Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
Plug 'junegunn/limelight.vim'

Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'      "ae/ie for entire file
Plug 'kana/vim-textobj-indent'      "ai/ii for indent block
Plug 'kana/vim-textobj-line'        "al/il for line
Plug 'sgur/vim-textobj-parameter'   "a,/i, for argument/parameter
Plug 'aoswalt/vim-textobj-elixir'   "aE/iE for Elixir blocks as remapped
Plug 'Julian/vim-textobj-variable-segment'    "av/iv for variable part
Plug 'Chun-Yang/vim-textobj-chunk'  "ac/ic for json-ish chunk
Plug 'whatyouhide/vim-textobj-xmlattr'  "ax/ix for xml attribute

Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'vim-scripts/dbext.vim'
Plug 'suan/vim-instant-markdown', { 'do': 'npm install -g instant-markdown-d' }
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'diepm/vim-rest-console'

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ap/vim-css-color'
Plug 'guns/xterm-color-table.vim'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'ryanoasis/vim-devicons'

Plug 'machakann/vim-highlightedyank'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-dadbod'

Plug 'aoswalt/onedark.vim'
Plug 'w0ng/vim-hybrid'

Plug 'wannesm/wmgraphviz.vim'
call plug#end()

" vim settings {{{1
set noswapfile
set number          "line numbers
set cursorline      "highlight cursorline
set ruler           "show line/column
set scrolloff=4     "keep more lines on screen while scrolling
set sidescroll=1    "horizontal scroll amount
set sidescrolloff=5 "horizontal scrolloff
set list            "enable invisible characters
set nowrap          "do not wrap lines by default
set mouse=a         "use mouse in all modes

" QoL tweaks
set tabstop=2       "width of tabs
set shiftwidth=2    "amount for < and > commands
set shiftround      "indent to the next multiple of shiftwidth
set expandtab       "insert spaces instead of tabs

" set hidden          "allow hiding a buffer instead of requring save
set splitbelow      "default horizontal split to lower
set splitright      "default vertical split to right

set ignorecase      "ignore caps when searching
set smartcase       "unless a capital is used
set infercase       "smart auto-completion casing
set wildignorecase  "ignore case on files and directories
set gdefault        "global search by default
set lazyredraw      "no need to redraw all the time
set nohlsearch      "don't highlight searches by default
set inccommand=nosplit  "show substitution while typing
set path+=**        "include subdirectory globbing in path for :find
set diffopt+=vertical   "vertical split for diffs

set noshowmode      "do not show mode since using lightline

" characters for horizontal scrolled text
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

set completeopt=longest,menuone

let g:mapleader = ' ' "use space as leader

if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undofile
set undodir=~/.config/nvim/undo/

" override $VISUAL to use nvr inside neovim
if executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" fix to not require extra keypress for fzf in terminal
let $FZF_DEFAULT_OPTS .= ' --no-height'



" plugin settings {{{1
let g:netrw_altfile = 1   "allow <c-6> to go to the previously edited file
let g:netrw_preview = 1   "open preview window in a vertical split
let g:netrw_localrmdir='rm -r'  "allow deleting non-empty directories

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

let g:highlightedyank_highlight_duration = 350

let g:ultisnips_javascript = {
\ 'semi': 'never',
\ 'space-before-function-paren': 'never',
\ }

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

let g:vim_textobj_elixir_mapping = 'E'

let g:tmux_navigator_no_mappings = 1

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let b:csv_arrange_use_all_rows = 1

let g:instant_markdown_autostart = 0

let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }
let g:quickrun_config['sh'] = { 'type': 'bash' }

let g:sql_type_default = 'pgsql'

let g:UltiSnipsEditSplit = 'horizontal'

let g:fzf_commands_expect = 'enter,ctrl-x'

let g:vrc_trigger = '<leader>r'

let g:limelight_conceal_ctermfg = 236

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
\  'num_processes': 0,
\})

let g:ale_linters = {
\  'javascript': ['eslint', 'tsserver'],
\  'elixir': ['elixir-ls', 'credo'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'elixir': ['mix_format'],
\}

let g:vista_default_executive = 'ale'

" autocommands {{{1
augroup whitespace
  " automatically strip trailiing whitespace on save
  autocmd BufWritePre * StripWhitespace
augroup end

augroup dispatch_commands
  autocmd FileType sh let b:dispatch = '$SHELL %'
  autocmd FileType dot let b:dispatch = 'dot -Tpng % -o %:r.png'
augroup end

augroup ft_match_words
  " add do/end as jumps for %
  autocmd FileType elixir let b:match_words = '\<\(do\|fn\)\>:\<end\>'
augroup end

" only show cursor line one active window
augroup cursorLine
  autocmd!
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
augroup end

augroup pum
  " auto-close preview pane
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

augroup term_settings
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup end

augroup term_insert
  " go into insert mode if switching to a terminal buffer
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

" colors {{{1
colorscheme onedark

highlight! IndentGuidesOdd  ctermbg=233
highlight! IndentGuidesEven ctermbg=234

highlight! jsBlock ctermfg=150
highlight! jsObjectKey ctermfg=139
highlight! Constant ctermfg=37
highlight! Normal ctermbg=NONE

highlight! Define ctermfg=239

augroup elixir_colors
  autocmd FileType elixir highlight! Identifier ctermfg=88
augroup end

" highlight! link TermCursor Cursor
highlight! TermCursorNC ctermbg=0 ctermfg=15

highlight Pmenu ctermbg=240
highlight PmenuSel ctermbg=25

" lighten non-active windows
highlight NormalNC ctermbg=234

" highlight line 80 and 120+
highlight ColorColumn ctermbg=232
let &colorcolumn="80,".join(range(120,999),",")

"blacklist some files for line length markers
autocmd FileType markdown let &colorcolumn=""


" keymappings {{{1
" swap ; and :
noremap ; :
noremap : ;

" pretty much always want very magic searches
nnoremap / /\v
nnoremap ? ?\v
cnoremap %s/ %s/\v
cnoremap s/ s/\v

" move cursor into wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj

" warning mappings lke unimpaired
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> ]W <Plug>(ale_last)

" split navigation
nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap <silent> <m-\> :TmuxNavigatePrevious<cr>
inoremap <silent> <m-h> <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <m-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <m-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <m-l> <esc>:TmuxNavigateRight<cr>

" terminal keybindings
tnoremap <leader><esc> <c-\><c-n>
tnoremap <m-[> <c-\><c-n>
tnoremap <m-h> <c-\><c-n><c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l

" tab switching like tmux
nnoremap <leader><m-h> :tabprev<cr>
nnoremap <leader><m-l> :tabnext<cr>

" window resizing
nnoremap <M-S-h> <C-w><
nnoremap <M-S-j> <C-w>+
nnoremap <M-S-k> <C-w>-
nnoremap <M-S-l> <C-w>>
nnoremap <silent> <M-=> <c-w>=
nnoremap <silent> <c-w>' :call ZoomToggle()<cr>
nnoremap <silent> <c-w>z :call MaximizeWindow()<cr>
nnoremap <silent> <M-'> :call ZoomToggle()<cr>
nnoremap <silent> <M-z> :call MaximizeWindow()<cr>

" open file to side
nnoremap gF :vertical wincmd f<CR>

" mimic D,C (to end of line)
nnoremap Y y$

" use Q to play q macro
nnoremap Q @q

" allow range commands from searches - ex:  /foo$m
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

" reselect pasted content:
noremap gV `[v`]

" insert time / date
nnoremap <leader>it "=strftime("%H:%M")<CR>P
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <leader>iD "=strftime("%m.%d.%Y")<CR>P

" netrw splits
noremap <silent> <leader>x :Vexplore!<CR>:wincmd =<CR>
noremap <silent> <leader>X :Sexplore<CR>:wincmd =<CR>

" use sudo for file if forgot to when opened
nnoremap <leader>sw :w !sudo tee % >/dev/null<cr>

" super find
nnoremap <leader>f :GFiles -co --exclude-per-directory=.gitignore<CR>
nnoremap <leader>F :FZF<CR>

" super search
nnoremap <leader>/ :Rg<space>
nnoremap <leader>? :BLines<space>

" buffer management
nnoremap <leader>b :Buffers<cr>
nnoremap <c-up> :ls<cr>:b
nnoremap <c-right> :bn<cr>
nnoremap <c-left> :bp<cr>
nnoremap <c-down> :bn \| bd #<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :bd<cr>

" search for word under cursor with <leader>*
nnoremap <leader>* :Rg <c-r><c-w><CR>

" system clipboard yank
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

" put searches in middle of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
xmap n nzz
xmap N Nzz
xmap * *zz
xmap # #zz
nmap g* g*zz
nmap g# g#zz

nnoremap <leader>d :Dispatch<cr>
vnoremap <leader>d :<c-u>execute ':Dispatch ' . substitute(b:dispatch, '%', shellescape(join(getline(line("'<"), line("'>")), "\n"), "\n"), "")<cr>

" search for visual selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>

" format
nmap <F4> <Plug>(ale_fix)

" full info
nmap <F10> <Plug>(ale_detail)

" pane toggles
nnoremap <F5> :MundoToggle<CR>
nnoremap <F6> :Vista!!<CR>

" edit vimrc/zshrc and source vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sf :source %<CR>

" save session
nnoremap <leader>s :mksession<CR>

" term splits like tmux
nnoremap <leader>\ :VTerm<CR>
nnoremap <leader>- :STerm<CR>
nnoremap <leader>\| :VTermRepo<CR>
nnoremap <leader>_ :STermRepo<CR>

" inside template tags
onoremap <silent> iT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
vnoremap <silent> iT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
onoremap <silent> aT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>
vnoremap <silent> aT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" run 'q' macro on selection
xnoremap Q :normal @q<CR>

" port 8090
nnoremap <leader>md :InstantMarkdownPreview<CR>

fun! MapLCKeys()
  " Don't map for built-in ones
  if &ft =~ 'vim\|help\|shell'
    return
  endif

  nmap <buffer> <silent> K <Plug>(ale_hover)
  nmap <buffer> gd <Plug>(ale_go_to_definition)
  nmap <buffer> <silent> gD <Plug>(ale_go_to_definition_in_vsplit)
  nmap <buffer> gy <Plug>(ale_find_references)
  nmap <buffer> gY <Plug>(ale_go_to_type_definition)
endfun

autocmd FileType * call MapLCKeys()

" fzf
" Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" fuzzy command list
nnoremap <leader><leader> :Commands<CR>

" fugitive bindings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gL :Git log -p %<cr>
nnoremap <leader>gr :Grebase -i --autosquash

nnoremap <leader>l :Limelight<cr>
nnoremap <leader>L :Limelight!<cr>
xmap <leader>l <Plug>(Limelight)


" commands {{{1
" close all other buffers
command! BufOnly :%bd|e#

command! BufCleanup :call BufCleanup()
command! SynStack :call SynStack()

" open a terminal in a different view
command! -nargs=* VTerm :vsp
  \ | execute 'terminal' <args>
command! -nargs=* VTermRepo :vsp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>
command! -nargs=* STerm :sp
  \ | execute 'terminal' <args>
command! -nargs=* STermRepo :sp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>
command! -nargs=* TTerm :tabnew
  \ | execute 'terminal' <args>
command! -nargs=* TTermRepo :tabedit
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>

" amend without editing commit message
command! Gamend Gcommit --amend --no-edit

command! -range FormatJSON :<line1>,<line2>call FormatJSON()

command! -nargs=* Gpc execute('Gpush --set-upstream origin '.FugitiveHead().' '.<q-args>)


" functions {{{1
function! MaximizeWindow()
  vertical resize
  resize
endfunction

let s:maximized=0
function! ZoomToggle()
  if s:maximized
    wincmd =
    let s:maximized=0
  else
    call MaximizeWindow()
    let s:maximized=1
  endif
endfunction

" override Ag and Rg commands to search inside git repo
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, {'dir': FugitiveWorkTree()}, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ {'dir': FugitiveWorkTree()},
    \ <bang>0
  \ )

" run macro on selection
function! g:ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" search for visual selection -  from practical vim
function! s:VSetSearch(cmdType)
  let l:temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdType.'\'), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

" show highlight stack
function! SynStack()
  let l:syns = synstack(line('.'), col('.'))
  call map(l:syns, {key, id -> [synIDattr(id, 'name'), synIDattr(synIDtrans(id), 'name')]})
  call map(l:syns, {key, pair -> ('[' . get(pair, 0) . '->' . get(pair, 1) . ']')})
  let l:stack = join(l:syns, ' => ')
  echo l:stack
endfunction

" Delete buffers that are not displayed in any window or modified
function! BufCleanup()
  let l:tabs = map(copy(gettabinfo()), 'v:val.tabnr')

  let l:openBuffers = []
  for l:i in l:tabs
     call extend(l:openBuffers, tabpagebuflist(l:i))
  endfor

  let l:buffers = map(filter(filter(copy(getbufinfo()), 'v:val.listed'), {i, info -> info.changed == v:false}), 'v:val.bufnr')
  for l:bnr in l:buffers
      if index(l:openBuffers, l:bnr) < 0
          exe 'bd '.l:bnr
      endif
  endfor
endfunction

" format a block of JSON with python's built-in function
function! FormatJSON() range
  let l:fullRange = a:firstline.','.a:lastline
  let l:singeLine = a:firstline.','.a:firstline
  silent exe l:fullRange.'join | '.l:singeLine.'! python3 -m "json.tool"'
  silent normal =}
endfunction



" statusline {{{1
"\   'colorscheme': 'onedark',
let g:lightline = {
\   'component': {
\     'mode': '%{lightline#mode() . " " . ObsessionStatus()}',
\     'readonly': '%{&readonly?"\ue0a2":""}',
\   },
\   'component_function': {
\     'filename': 'FilenameWithIcon',
\     'gitversion': 'GitVersion'
\   },
\   'active': {
\     'right': [
\        [ 'lineinfo'],
\        [ 'gitversion', 'percent' ],
\        [ 'fileformat', 'filetype' ],
\     ]
\   },
\   'inactive': {
\     'right': [
\        [ 'lineinfo' ],
\        [ 'gitversion', 'percent' ],
\     ]
\   },
\ }

" custom icon overrides
let s:icons = {
\   'jsx': "\ue7ba",
\   'javascript.jsx': "\ue7ba",
\   'nginx': "\ue776",
\ }

function! FilenameWithIcon()
  if exists('*WebDevIconsGetFileTypeSymbol')
    let l:icon = index(keys(s:icons), &filetype) > -1 ? s:icons[&filetype] : WebDevIconsGetFileTypeSymbol()
  else
    let l:icon = ''
  endif
  let l:filename = expand('%')
  return len(l:filename) > 0 ? l:filename . ' ' . l:icon : '[No File]'
endfunction

function! GitVersion()
  let l:fullname = expand('%')
  let l:gitversion = ''
  if l:fullname =~? 'fugitive://.*/\.git//0/.*'
    let l:gitversion = 'git index'
  elseif l:fullname =~? 'fugitive://.*/\.git//2/.*'
    let l:gitversion = 'git target'
  elseif l:fullname =~? 'fugitive://.*/\.git//3/.*'
    let l:gitversion = 'git merge'
  elseif &diff == 1
    let l:gitversion = 'working copy'
  endif
  return l:gitversion
endfunction



" after.vim loading {{{1
" allow loading of device specific configs
if filereadable(expand('$HOME/init.after.vim'))
  source $HOME/init.after.vim
endif
