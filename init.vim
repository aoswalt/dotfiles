" install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree' , {'on': 'NERDTreeToggle'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Raimondi/delimitMate'
Plug 'neomake/neomake', {'on': 'Neomake'}
Plug 'airblade/vim-gitgutter'
Plug 'aoswalt/onedark.vim'
call plug#end()

" display/ui
set t_Co=256
colorscheme onedark

set number          "line numbers
set cursorline      "highlihght cursorline
set scrolloff=4     "keep more lines on screen while scrolling
set list            "enable invisible characters


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

nnoremap <silent> <leader>n :NERDTreeToggle<CR>


let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert  "auto-select first completion


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
