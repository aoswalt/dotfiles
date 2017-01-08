" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree' , {'on': 'NERDTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }

Plug 'vimwiki/vimwiki'
Plug 'gko/vim-coloresque'

Plug 'Raimondi/delimitMate'
Plug 'neomake/neomake', {'on': 'Neomake'}
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'aoswalt/onedark.vim'

" ctags require https://github.com/universal-tags/ctags
Plug 'ludovicchabant/vim-gutentags', {'do': ':call plug#helptags()'}
Plug 'majutsushi/tagbar'
call plug#end()

set encoding=utf8

" display/ui
set t_Co=256
set background=dark
colorscheme onedark

" reduce devicons spacing
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

"hide extra characters from devicons in nerdtree
autocmd FileType nerdtree setlocal nolist

set number          "line numbers
set cursorline      "highlight cursorline
set scrolloff=4     "keep more lines on screen while scrolling
set list            "enable invisible characters

" automatically strip trailiing whitespace on save
autocmd BufWritePre * StripWhitespace


" QoL tweaks
set tabstop=2
set shiftwidth=2
set expandtab

set hidden          "allow hiding a buffer instead of requring save
set splitbelow      "default horizontal split to lower
set splitright      "default vertical split to right


" keybindings
let mapleader = ' ' "use space as leader

"move cursor into wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj

"mimic D,C
nmap Y y$

" toggle search highlight
nnoremap <leader>hs :set hlsearch!<CR>

" cycle through popup menu options with <TAB>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
map <leader>/ <plug>NERDCommenterToggle<CR><Up>
let g:NERDTrimTrailingWhitespace = 1


let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert  "auto-select first completion

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

autocmd! BufWritePost * Neomake

let g:livedown_browser = "firefox"
nnoremap <leader>md :LivedownToggle<CR>


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
