" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree' , {'on': 'NERDTreeToggle'}
Plug 'aoswalt/onedark.vim'
call plug#end()

let mapleader = ' ' "use space as leader

set t_Co=256
colorscheme onedark

set cursorline      "highlihght cursorline
set incsearch       "highlight first matching search while typing
set scrolloff=4     "keep more lines on screen while scrolling

set undolevels=100  "more undo history

"move cursor into wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj

set hidden          "allow hiding a buffer instead of requring save

nnoremap <silent> <leader>n :NERDTreeToggle<CR>

let curPath = expand("<amatch>")
if isdirectory(curPath) || empty(curPath)
      NERDTree
      wincmd p
      bd
endif
