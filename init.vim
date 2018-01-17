scriptencoding utf-8

" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    autocmd VimEnter * PlugInstall
  augroup end
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'

Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'galooshi/vim-import-js', { 'do': 'npm install -g import-js', 'for': ['javascript', 'javascript.jsx'] }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-zsh'
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/phoenix.vim', { 'for': 'elixir' }
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SyntaxRange'

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
Plug 'vimwiki/vimwiki'
Plug 'mtth/scratch.vim'
Plug 'suan/vim-instant-markdown', { 'do': 'npm install -g instant-markdown-d' }
Plug 'chrisbra/csv.vim'

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'systemmonkey42/vim-coloresque'
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
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'aoswalt/onedark.vim'
Plug 'w0ng/vim-hybrid'

" ctags require https://github.com/universal-ctags/ctags
Plug 'ludovicchabant/vim-gutentags', {'do': ':call plug#helptags()'}
Plug 'majutsushi/tagbar'
call plug#end()

" override $VISUAL to use nvr inside neovim
if executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif


let g:ultisnips_javascript = {
\ 'semi': 'never',
\ 'space-before-function-paren': 'never',
\ }

set completeopt=longest,menuone

" fix to not require extra keypress for fzf in terminal
let $FZF_DEFAULT_OPTS .= ' --no-height'

" tern tweaks
let g:tern_show_signature_in_pum = 1
let g:tern#filetypes = ['javascript', 'jsx', 'javascript.jsx']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#include_keywords = 1

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

let g:vim_textobj_elixir_mapping = 'E'

" leader-K to go to definition of js via tern
augroup javascript_help
  autocmd FileType javascript.jsx nnoremap <buffer> <leader>k :TernType<cr>
  autocmd FileType javascript.jsx nnoremap <buffer> <leader>K :TernDef<cr>
augroup end

" display/ui
colorscheme onedark

set noswapfile
set number          "line numbers
set cursorline      "highlight cursorline
set ruler           "show line/column
set scrolloff=4     "keep more lines on screen while scrolling
set sidescroll=5    "horizontal scrolloff
set list            "enable invisible characters
set nowrap          "do not wrap lines by default
set mouse=a         "use mouse in all modes

" automatically strip trailiing whitespace on save
autocmd BufWritePre * StripWhitespace


" QoL tweaks
set tabstop=2       "width of tabs
set shiftwidth=2    "amount for < and > commands
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
set path+=**        "include subdirectory globbing in path

" set autochdir       "switch to current file's parent directory
augroup vimrc_set_working_dir
  au!
  autocmd BufRead,BufEnter * silent! lcd %:p:h
augroup end

let g:netrw_altfile = 1   "allow <c-6> to go to the previously edited file
let g:netrw_preview = 1   "open preview window in a vertical split


if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undofile
set undodir=~/.config/nvim/undo/


let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
highlight! IndentGuidesOdd  ctermbg=233
highlight! IndentGuidesEven ctermbg=234

highlight! jsBlock ctermfg=150
highlight! jsObjectKey ctermfg=139
highlight! Constant ctermfg=37
highlight! Normal ctermbg=NONE

" highlight! link TermCursor Cursor
highlight! TermCursorNC ctermbg=0 ctermfg=15

" use - and . as word separators
set iskeyword-=-
set iskeyword-=.

let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint']

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']

let g:highlightedyank_highlight_duration = 350

" disable continuation of comments to the next line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" only show cursor line one active window
augroup cursorLine
  autocmd!
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
augroup END

" keybindings
let g:mapleader = ' ' "use space as leader

" swap ; and :
noremap ; :
noremap : ;

" pretty much always want very magic searches
nnoremap / /\v
nnoremap ? ?\v
cnoremap %s/ %s/\v

" move cursor into wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj

" warning mappings lke unimpaired
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)


let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap <silent> <m-\> :TmuxNavigatePrevious<cr>

" terminal keybindings
tnoremap <leader><esc> <c-\><c-n>
tnoremap <m-[> <c-\><c-n>
tnoremap <m-h> <c-\><c-n><c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l

inoremap <m-h> <esc><c-w>h
inoremap <m-j> <esc><c-w>j
inoremap <m-k> <esc><c-w>k
inoremap <m-l> <esc><c-w>l

nnoremap <leader><m-h> :tabprev<cr>
nnoremap <leader><m-l> :tabnext<cr>

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


" window resizing
nnoremap <M-S-h> <C-w><
nnoremap <M-S-j> <C-w>+
nnoremap <M-S-k> <C-w>-
nnoremap <M-S-l> <C-w>>
nnoremap <silent> <M-=> <c-w>=
nnoremap <silent> <c-w>' :call MaximizeWindow()<cr>
nnoremap <silent> <c-w>z :call ZoomToggle()<cr>
nnoremap <silent> <M-'> :call MaximizeWindow()<cr>
nnoremap <silent> <M-z> :call ZoomToggle()<cr>

" open file to side
nnoremap gF :vertical wincmd f<CR>

" mimic D,C
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

" commenting
map <leader>/ gcc
vmap <leader>/ gc

noremap <silent> <leader>x :Vexplore!<CR>:wincmd =<CR>
noremap <silent> <leader>X :Sexplore<CR>:wincmd =<CR>

" use sudo for file if forgot to when opened
nnoremap <leader>sw :w !sudo tee % >/dev/null<cr>

" use <leader>p to open fzf with git files
nnoremap <leader>p :GFiles -co --exclude-per-directory=.gitignore<CR>
" plain FZF vs GFiles have a few differences to be sorted out
nnoremap <leader>P :FZF<CR>
nnoremap <leader>f :Ag<space>
nnoremap <leader>F :BLines<space>

" buffer management
nnoremap <leader>bf :Buffers<cr>
nnoremap <leader>bl :ls<cr>:b
nnoremap <silent> <leader>bd :bn \| bd #<cr>
nnoremap <leader>q :bd<cr>

" search for word under cursor with <leader>*
nnoremap <leader>* :Ag <c-r><c-w><CR>

" system clipboard yank
nnoremap <leader>y "+y
vnoremap <leader>y "+y

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

" search count alongside search
" right command but needs some tweaking to seamlessly integrate
" nnoremap * *n<c-o>:%s///gn<CR>

" search for visual selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>


" pane toggles
nnoremap <F5> :MundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>


let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 100
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#auto_complete_delay = 1
" let g:deoplete#enable_refresh_always = 1
highlight Pmenu ctermbg=240
highlight PmenuSel ctermbg=25

" lighten non-active windows
highlight NormalNC ctermbg=234

" auto-close preview pane
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" extra location list keybinds (some with unimpaired)
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>ll :ll<CR>

" extra quickfix keybinds (some with unimpaired)
nnoremap <Leader>co :Copen<CR>
nnoremap <Leader>cc :cclose<CR>

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

let g:gutentags_cache_dir = '~/.tags_cache'

" port 8090
nnoremap <leader>md :InstantMarkdownPreview<CR>

let b:csv_arrange_use_all_rows = 1

let g:scratch_insert_autohide = 0


let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }
let g:quickrun_config['sh'] = { 'type': 'bash' }

let g:sql_type_default = 'pgsql'


" use pgsql syntax inside elixir non-doc string blocks
augroup elixirSql
  autocmd!
  autocmd FileType elixir call SyntaxRange#Include('\s\{2,\}\"\"\"', '\"\"\"', 'pgsql', 'NonText')
augroup end


" extracted from inside fzf
function! s:get_git_root()
  try
    return fugitive#repo().tree()
  catch
    return ''
  endtry
endfunction

" override Ag command to search inside git repo
function! fzf#vim#ag_raw(command_suffix, ...)
  return call('fzf#vim#grep', extend(['ag --nogroup --column --color '.a:command_suffix.' '.s:get_git_root(), 1], a:000))
endfunction

" from issue, but doesn't work at all in non-repo
"command! -bang -nargs=* GitAg\ call fzf#vim#ag(<q-args>, {'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)

" run macro on selection
function! s:ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" run 'q' macro on selection
xnoremap Q :normal @q<CR>

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
command! SynStack :call SynStack()

" close all other buffers
command! BufOnly :%bd|e#

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
command! BufCleanup :call BufCleanup()

" open a terminal in a different view
command! -nargs=* VTerm :vsp|terminal <args>
command! -nargs=* VTermRepo :vsp|execute 'lcd' fnameescape(s:get_git_root())|terminal <args>
command! -nargs=* STerm :sp|terminal <args>
command! -nargs=* STermRepo :sp|execute 'lcd' fnameescape(s:get_git_root())|terminal <args>
command! -nargs=* TTerm :tabnew|terminal <args>
command! -nargs=* TTermRepo :tabnew|execute 'lcd' fnameescape(s:get_git_root())|terminal <args>

" format a block of JSON with python's built-in function
function! FormatJSON() range
  let l:fullRange = a:firstline.','.a:lastline
  let l:singeLine = a:firstline.','.a:firstline
  silent exe l:fullRange.'join | '.l:singeLine.'! python3 -m "json.tool"'
  silent normal =}
endfunction
command! -range FormatJSON :<line1>,<line2>call FormatJSON()

" go into insert mode if switching to a terminal buffer
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" comment jsx lines in javascript.jsx files
"autocmd FileType javascript.jsx
"\ let jsxRegionID = hlID('jsxRegion') |
"\ autocmd CursorMoved *
"\   if index(synstack(line("."), col("$") - 1), jsxRegionID) > 0 |
"\     setlocal commentstring={/*\ %s\ */} |
"\   else |
"\     setlocal commentstring=//%s |
"\   endif

" command to fix netrw buftype shenanigans
command! FixBuftype set buftype=<space>

" amend without editing commit message
command! Gamend Gcommit --amend --no-edit

" more solid vertical bar
set fillchars=vert:\│

set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

set diffopt+=vertical

set noshowmode
"\   'colorscheme': 'onedark',
let g:lightline = {
\   'component': {
\     'readonly': '%{&readonly?"\ue0a2":""}',
\   },
\   'component_function': {
\     'filename': 'FilenameWithIcon',
\   },
\   'active': {
\     'right': [
\        [ 'lineinfo' ],
\        [ 'percent' ],
\        [ 'fileformat', 'filetype' ],
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


" allow loading of device specific configs
if filereadable(expand('$HOME/init.after.vim'))
  source $HOME/init.after.vim
endif
