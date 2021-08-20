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

Plug 'justinmk/vim-dirvish'
Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'wsdjeg/vim-fetch'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
Plug 'plasticboy/vim-markdown'  "included in polyglot but without extra features
Plug 'junegunn/limelight.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'L3MON4D3/LuaSnip'
Plug 'w0rp/ale'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'              "ae/ie for entire file
Plug 'kana/vim-textobj-indent'              "ai/ii for indent block
Plug 'kana/vim-textobj-line'                "al/il for line
Plug 'sgur/vim-textobj-parameter'           "a,/i, for argument/parameter
Plug 'Julian/vim-textobj-variable-segment'  "av/iv for variable part
Plug 'Chun-Yang/vim-textobj-chunk'          "ac/ic for json-ish chunk
Plug 'whatyouhide/vim-textobj-xmlattr'      "ax/ix for xml attribute

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'godlygeek/tabular'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'diepm/vim-rest-console'
Plug 'wesQ3/vim-windowswap'

Plug 'itchyny/lightline.vim'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ap/vim-css-color'
Plug 'aoswalt/xterm-color-table.vim'
Plug 'vim-scripts/AnsiEsc.vim'

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
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-dadbod'

Plug 'wannesm/wmgraphviz.vim'
call plug#end()

set runtimepath+=$DOTFILES/nvim,$DOTFILES/nvim/after
set packpath+=$DOTFILES/nvim

let path = expand('$DOTFILES/nvim')

lua require'disable'

exec 'source' path . '/settings.vim'
exec 'source' path . '/statusline.vim'
exec 'source' path . '/keys.vim'
exec 'source' path . '/autocommands.vim'

lua U = require'util'

" after.vim loading {{{1
" allow loading of device specific configs
if filereadable(expand('$HOME/init.after.vim'))
  source $HOME/init.after.vim
endif
