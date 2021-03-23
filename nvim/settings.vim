colorscheme unemphatic

set noswapfile
set number              "line numbers
set cursorline          "highlight cursorline
set ruler               "show line/column
set scrolloff=4         "keep more lines on screen while scrolling
set sidescroll=1        "horizontal scroll amount
set sidescrolloff=5     "horizontal scrolloff
set list                "enable invisible characters
set nowrap              "do not wrap lines by default
set mouse=a             "use mouse in all modes

set tabstop=2           "width of tabs
set shiftwidth=2        "amount for < and > commands
set shiftround          "indent to the next multiple of shiftwidth
set expandtab           "insert spaces instead of tabs

" set hidden            "allow hiding a buffer instead of requring save
set splitbelow          "default horizontal split to lower
set splitright          "default vertical split to right

set ignorecase          "ignore caps when searching
set smartcase           "unless a capital is used
set infercase           "smart auto-completion casing
set wildignorecase      "ignore case on files and directories
set gdefault            "global search by default
set lazyredraw          "no need to redraw all the time
set nohlsearch          "don't highlight searches by default
set inccommand=nosplit  "show substitution while typing
set path+=**            "include subdirectory globbing in path for :find
set diffopt+=vertical   "vertical split for diffs

set noshowmode          "do not show mode since using lightline

" characters for horizontal scrolled text
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

" set completeopt=menuone,longest
set completeopt=menuone,noinsert

let g:mapleader = ' ' "use space as leader

if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undofile
set undodir=~/.config/nvim/undo/

" highlight line 80 and 120+
let &colorcolumn="80,".join(range(120,999),",")

" use %% for local relative paths
cabbrev <expr> %% expand('%:p:h')

" override $VISUAL to use nvr inside neovim
if executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
