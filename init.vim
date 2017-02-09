" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}
Plug 'ryanoasis/vim-devicons', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'simnalamburt/vim-mundo'

Plug 'neomake/neomake', {'on': 'Neomake'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/phoenix.vim'

Plug 'thinca/vim-quickrun'

Plug 'vimwiki/vimwiki'
Plug 'mtth/scratch.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'chrisbra/csv.vim'

Plug 'gko/vim-coloresque'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'

Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

Plug 'aoswalt/onedark.vim'
Plug 'w0ng/vim-hybrid'

" ctags require https://github.com/universal-ctags/ctags
Plug 'ludovicchabant/vim-gutentags', {'do': ':call plug#helptags()'}
Plug 'majutsushi/tagbar'
call plug#end()

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

" reduce devicons spacing
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

" hide extra characters from devicons in nerdtree
autocmd FileType nerdtree setlocal nolist

set number          "line numbers
set rnu             "relative line numbers
set cursorline      "highlight cursorline
set ruler           "show line/column
set scrolloff=4     "keep more lines on screen while scrolling
set sidescroll=5    "horizontal scrolloff
set list            "enable invisible characters
set nowrap          "do not wrap lines by default

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

set autochdir       "switch to current file's parent directory


if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//


let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=235


" keybindings
let mapleader = ' ' "use space as leader

" quick sourcing for working on vim files
nnoremap <leader>\ :source %<CR>

" use ; for commands
nnoremap ; :

" move cursor into wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj

" mimic D,C
nnoremap Y y$

" use Q to play last macro
nnoremap Q @@

" leader-w to save
nnoremap <leader>w :w<CR>

" toggle search highlight
nnoremap <leader>hs :noh<CR>

" cycle through popup menu options with <TAB>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
map <leader>/ <plug>NERDCommenterToggle<CR><Up>
let g:NERDTrimTrailingWhitespace = 1

nnoremap <leader>tb :TagbarToggle<CR>


" use <C-p> to open fzf
nnoremap <C-p> :GFiles -co<CR>

nnoremap <F5> :MundoToggle<CR>

let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert  "auto-select first completion
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

let g:gutentags_cache_dir = '~/.tags_cache'

let g:livedown_browser = "firefox"
nnoremap <leader>md :LivedownToggle<CR>

let b:csv_arrange_use_all_rows = 1


let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }


" below taken from janus to have expected NERDTree usage
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function! s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function! s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

augroup END
