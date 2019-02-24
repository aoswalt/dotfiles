#! /bin/bash

normal=$'\033[0m'
bold=$'\033[1m'
black=$'\033[30m'
red=$'\033[31m'
green=$'\033[32m'
yellow=$'\033[33m'
blue=$'\033[34m'
purple=$'\033[35m'
cyan=$'\033[36m'
white=$'\033[37m'

# get script's directory
this_dir=$(cd $(dirname $0); pwd -P)

function log() {
  echo -e $1
}

function log_info() {
  [[ $verbose ]] && echo -e $1
}

function log_warn() {
  echo -e "${yellow}$1${normal}"
}

function log_error() {
  echo -e "${red}$1${normal}"
}

# try to create a symlink to $1 at $2
function try_link() {
  file=$1
  dst_dir=${2:-$HOME}
  src_dir=${3:-$this_dir}

  src_path=$src_dir/$file
  dst_path=$dst_dir/$file

  if [[ -e $dst_path || -L $dst_path ]]; then
    if [[ $all_yes ]]; then
      choice='y'
    elif [[ ! -z $all_no ]]; then
      choice='n'
    else
      read -p "${cyan}$dst_path${normal} already exists. ${red}${bold}Remove?${normal} [y/${red}${bold}N${normal}]:  " choice
    fi

    if [[ $choice =~ ^[Yy] ]]; then
      log_info "Removing ${cyan}$dst_path${normal}"
      rm $dst_path
    else
      log_info "Not removing ${cyan}$dst_path${normal}"
    fi
  fi

  if [[ ! -e $dst_path ]]; then
    log_error "$dst_path already exists. Cannot create link."
    return 1
  fi

  ln -s $src_path $dst_path

  if [[ -z $? ]]; then
    log_info "Link created for ${cyan}$dst_path${normal}"
  else
    log_info "Could not create link for ${cyan}$dst_path${normal}"
    return 1
  fi
}

# call try_link for each file in an array
function try_link_each() {
  local -n files=$1

  for filename in ${files[*]}; do
    try_link $filename $2 $3
  done
}

# clone and install asdf
function install_asdf() {
  if $(type asdf >/dev/null); then
    log_info "asdf already installed"
    return 0
  fi

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3

  [[ ! -z $? ]] && return 1

  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
  log_info "asdf installed"
}

# install the specified language and version with asdf
function install_language() {
  lang=$1
  version=$2

  if [[ -z $lang || -z $version ]]; then
    log_error "install_language() requires 2 arguments: language and version"
    return 1
  fi

  if ! $(type asdf >/dev/null); then
    log_error "asdf not found"
    return 1
  fi

  log_info "Setting up asdf ${cyan}$lang${normal} for version ${cyan}$version${normal}"

  if [[ ! $(asdf plugin-list | grep "$lang" >/dev/null) ]]; then
    log_info "Adding asdf plugin: ${cyan}$lang${normal}"
    asdf plugin-add $lang

    [[ ! -z $? ]] && return 1
  else
    log_info "asdf plugin already exists: ${cyan}$lang${normal}"
  fi

  # node needs gpg keys added
  if [[ $lang == 'nodejs' ]]; then
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  fi

  if ! $(asdf list $lang | grep "$version" >/dev/null); then
    log_info "Installing asdf language: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf install $lang $version

    [[ ! -z $? ]] && return 1
  else
    log_info "asdf language version already exists: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  if ! $(asdf current $lang | grep "$version" >/dev/null); then
    log_info "Setting asdf global: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf global $lang $version

    [[ ! -z $? ]] && return 1
  else
    log_info "asdf gloabl version already set: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  asdf reshim $lang $version

  [[ ! -z $? ]] && return 1
}

# link neovim files, add neovim python packages, and add edit overrides
function setup_neovim() {
  nvim_dir=$HOME/.config/nvim
  mkdir -p ${nvim_dir}

  config_files=(
    init.vim
    coc-settings.json
    UltiSnips
  )

  try_link_each config_files $nvim_dir

  if [[ ! $(type pip3 >/dev/null 2>&1) ]]; then
    log_error "pip3 not found - python neovim package needed for proper usage"
    return 1
  fi

  if [[ $(pip3 list 2>/dev/null | grep 'pynvim') ]]; then
    log_info "Python neovim package already installed"
  else
    log_info "Installing neovim python3 package - pynvim"
    pip3 install --user pynvim
  fi

  if [[ $(pip3 list 2>/dev/null | grep 'neovim-remote') ]]; then
    log_info "Python neovim package already installed"
  else
    log_info "Installing neovim-remote python3 package"
    pip3 install --user neovim-remote
  fi

  log_info "Clearing editor from git config to use env"
  git config --global --unset core.editor
  # git config --local --unset core.editor

  if [ -n "$(git config --system core.editor)" ]; then
    log_warn "WARNING: git system editor set"
  fi

  if [[ ! -e ~/init.after.vim && ! -L ~/int.after.vim ]]; then
    log_info "Adding init.after.vim for direct 'edit vim' mapping."
    echo "nnoremap <leader>ev :vsp $this_dir/init.vim<CR>" > ~/init.after.vim
    echo "nnoremap <leader>ez :vsp $this_dir/.zshrc<CR>" >> ~/init.after.vim
  else
    log_warn "init.after.vim already exists, not adding direct edit overrides."
  fi
}

# clone and install fzf
function setup_fzf() {
  if $(type fzf >/dev/null 2>&1); then
    log_info "fzf found - not cloning"
    return 0
  fi

  log_info "Cloning fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  log_info "Running fzf install"
  $HOME/.fzf/install

  [[ ! -z $? ]] && return 1
}

function clone_prezto() {
  if [[ -e "${ZDOTDIR:-$HOME}/.zprezto"  ]]; then
    log_info "Prezto already exists - not cloning"
    return 0
  fi

  log_info "Cloning Prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
}

function link_prezto_files() {
  prezto_files=(
    .zlogin
    .zlogout
    .zpreztorc
    .zprofile
    .zshenv
    .zshrc
  )

  try_link_each prezto_files
}

# set zsh as default shell
function set_zsh() {
  if [[ $(echo $SHELL | grep 'zsh') ]]; then
    log_info "Zsh already default shell"
    return 0
  fi

  if [[ ! $(grep zsh /etc/shells) ]]; then
    log_error "Zsh not found in /etc/shells"
    return 1
  fi

  chsh -s $(which zsh)

  [[ ! -z $? ]] && return 1

  # run zsh in current shell
  [[ ! -z $ZSH_NAME ]] && exec zsh
}

# print help and exit
function print_help_abort() {
  echo '
Usage: install options...
-h  help      This output

Script settings:
-A  All       Install all options
-Y  yes       Accept all confirmation prompts
-N  no        Deny all confirmation prompts
-V  verbose   Enable extra logging

Installable options:
-b  bash      Link bashrc
-e  eslint    Link eslintrc
-f  fzf       Setup fzf
-n  neovim    Setup neovim and link init.vim
-p  prezto    Clone prezto and link configuration files
-t  tmux      Link tmux configuration
-z  zsh       Set zsh as shell
'
  exit 1
}

# display help if no arguments
if (($# == 0)); then
  print_help_abort
fi

while getopts 'hAYNVbefnptz' flag; do
  case "${flag}" in
    h) print_help_abort ;;

    A) all=1 ;;
    Y) all_yes=1 ;;
    N) all_no=1 ;;
    V) verbose=1 ;;

    b) setup_bash=1 ;;
    e) setup_eslint=1 ;;
    f) setup_fzf=1 ;;
    n) setup_neovim=1 ;;
    p) setup_prezto=1 ;;
    t) setup_tmux=1 ;;
    z) set_zsh=1 ;;

    \?) print_help_abort ;;
  esac
done


[[ $setup_bash || $all ]] && try_link .bashrc
[[ $setup_eslint || $all ]] && try_link .eslintrc.json
[[ $setup_tmux || $all ]] && try_link .tmux.conf
[[ $setup_neovim || $all ]] && setup_neovim
[[ $setup_fzf || $all ]] && setup_fzf
[[ $setup_prezto || $all ]] && clone_prezto && link_prezto_files
[[ $set_zsh || $all ]] && set_zsh
