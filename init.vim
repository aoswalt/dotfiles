" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'

Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake', {'on': 'Neomake'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/phoenix.vim', { 'for': 'elixir' }
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SyntaxRange'

Plug 'thinca/vim-quickrun'
Plug 'vim-scripts/dbext.vim'
Plug 'vimwiki/vimwiki'
Plug 'mtth/scratch.vim'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'chrisbra/csv.vim'

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gko/vim-coloresque'
Plug 'guns/xterm-color-table.vim'
Plug 'vim-scripts/AnsiEsc.vim'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'aoswalt/onedark.vim'
Plug 'w0ng/vim-hybrid'

" ctags require https://github.com/universal-ctags/ctags
Plug 'ludovicchabant/vim-gutentags', {'do': ':call plug#helptags()'}
Plug 'majutsushi/tagbar'
call plug#end()

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

set completeopt=longest,menuone
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'
let g:tern#filetypes = ['jsx', 'javascript.jsx']

" allow shift-K to use :help instead of :man
autocmd FileType help setlocal keywordprg=:help
autocmd FileType vim setlocal keywordprg=:help

set encoding=utf8

" display/ui
set t_Co=256
set background=dark
let g:hybrid_custom_term_colors = 1
colorscheme onedark
"colorscheme hybrid

set number          "line numbers
set rnu             "relative line numbers
set cursorline      "highlight cursorline
set ruler           "show line/column
set scrolloff=4     "keep more lines on screen while scrolling
set sidescroll=5    "horizontal scrolloff
set list            "enable invisible characters
set nowrap          "do not wrap lines by default

" toggle relative number based on insert
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" automatically strip trailiing whitespace on save
autocmd BufWritePre * StripWhitespace


" QoL tweaks
set tabstop=2       "width of tabs
set shiftwidth=2    "amount for < and > commands
set expandtab       "insert spaces instead of tabs

set hidden          "allow hiding a buffer instead of requring save
set splitbelow      "default horizontal split to lower
set splitright      "default vertical split to right

set ignorecase      "ignore caps when searching
set smartcase       "unless a capital is used
set gdefault        "global search by default
set magic           "use extended regular expressions
set lazyredraw      "no need to redraw all the time

"set autochdir       "switch to current file's parent directory
augroup vimrc_set_working_dir
  au!
  autocmd BufEnter * silent! lcd %:p:h
augroup end

let g:netrw_altfile=1   "allow <c-6> to go to the previously edited file


if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undofile
set undodir=~/.config/nvim/undo/


let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=235

" use - and . as word separators
set isk-=-
set isk-=.

" disable continuation of comments to the next line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" keybindings
let mapleader = ' ' "use space as leader

" quick sourcing for working on vim files
nnoremap <leader>\ :source %<CR>

" swap ; and :
noremap ; :
noremap : ;

" move cursor into wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj

" mimic D,C
nnoremap Y y$

" use Q to play q macro
nnoremap Q @q

" toggle search highlight
nnoremap <leader>hs :noh<CR>

" hard toggle for highlight
"nnoremap <leader>hl :set hlsearch! hlsearch?<CR>
" off / on
nnoremap [h :set nohlsearch<CR>
nnoremap ]h :set hlsearch<CR>

" quickfix prev/next/first/last like unimpaired
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :crewind<CR>
nnoremap ]Q :clast<CR>

" buffer prev/next/first/last like unimpaired
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" arg list prev/next/first/last like unimpaired
nnoremap [b :bprevious<CR>
nnoremap [a :prev<CR>
nnoremap ]a :next<CR>
nnoremap [A :rewind<CR>
nnoremap ]A :last<CR>

" allow range commands from searches - ex:  /foo$m
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

" reselect pasted content:
noremap gV `[v`]

" insert time / date
nnoremap <leader>it "=strftime("%H:%M")<CR>P"
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P"
nnoremap <leader>iD "=strftime("%m.%d.%Y")<CR>P"

" cycle through popup menu options with <TAB>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

map <leader>/ gcc

noremap <leader>x :Vexplore!<CR>:wincmd =<CR>
noremap <leader><s-x> :Explore<CR>

" use sudo for file if forgot to when opened
cmap w!! w !sudo tee % >/dev/null

" search count
nnoremap * *n<C-O>:%s///gn<CR>

" use <C-p> to open fzf with git files
nnoremap <c-p> :GFiles -co --exclude-per-directory=.gitignore<CR>
nnoremap <leader>p :GFiles -co --exclude-per-directory=.gitignore<CR>
nnoremap <leader>P :FZF<CR>
nnoremap <leader>f :Ag<space>

" search for word under cursor with <leader>*
nnoremap <leader>* :Ag <c-r><c-w><CR>

" put searches in middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap <F5> :MundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>


let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 100
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#auto_complete_delay = 1
hi Pmenu ctermbg=240
hi PmenuSel ctermbg=25

" auto-close preview pane
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

" Neomake on open or write, leader-l for issues
autocmd! BufReadPost,BufWritePost * Neomake
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

let g:gutentags_cache_dir = '~/.tags_cache'

let g:livedown_browser = "firefox"
nnoremap <leader>md :LivedownToggle<CR>

let b:csv_arrange_use_all_rows = 1

let g:scratch_insert_autohide = 0


let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }
let g:quickrun_config['sh'] = { 'type': 'bash' }

let g:sql_type_default = 'pgsql'


" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]


" use pgsql syntax inside elixir non-doc string blocks
au FileType elixir call SyntaxRange#Include('\s\{2,\}\"\"\"', '\"\"\"', 'pgsql', 'NonText')


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
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" run 'q' macro on selection
function! ExecuteQMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @q"
endfunction

xnoremap Q :<C-u>call ExecuteQMacroOverVisualRange()<CR>


" print highlight group of word under cursor
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
\   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\ }


" allow loading of device specific configs
if filereadable(expand('$HOME/init.after.vim'))
  source $HOME/init.after.vim
endif
