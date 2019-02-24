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

# echo if verbose
function info() {
  [[ $verbose ]] && echo -e $1
}

# try to create a symlink to $1 at $2
function try_link() {
  src_path=$1
  dst_path=$2

  if [[ -e $dst_path || -L $dst_path ]]; then
    if [[ $all_yes ]]; then
      choice='y'
    elif [[ ! -z $all_no ]]; then
      choice='n'
    else
      read -p "${cyan}$dst_path${normal} already exists. ${red}${bold}Remove?${normal} [y/${red}${bold}N${normal}]:  " choice
    fi

    if [[ $choice =~ ^[Yy] ]]; then
      info "Removing ${cyan}$dst_path${normal}"
      rm $dst_path
    else
      info "Not removing ${cyan}$dst_path${normal}"
    fi
  fi

  if [[ ! -e $dst_path ]]; then
    echo -e "${red}$dst_path already exists. Cannot create link.${normal}"
    return 1
  fi

  ln -s $src_path $dst_path

  if [[ -z $? ]]; then
    info "Link created for ${cyan}$dst_path${normal}"
  else
    info "Could not create link for ${cyan}$dst_path${normal}"
    return 1
  fi
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

# clone and install asdf
function install_asdf() {
  if $(type asdf >/dev/null); then
    info "asdf already installed"
    return 0
  fi

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3

  [[ ! -z $? ]] && return 1

  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
  info "asdf installed"
}

# install the specified language and version with asdf
function install_language() {
  lang=$1
  version=$2

  if [[ -z $lang || -z $version ]]; then
    echo -e "${red}install_language() requires 2 arguments: language and version${normal}"
    return 1
  fi

  if ! $(type asdf >/dev/null); then
    echo -e "${red}asdf not found${normal}"
    return 1
  fi

  info "Setting up asdf ${cyan}$lang${normal} for version ${cyan}$version${normal}"

  if [[ ! $(asdf plugin-list | grep "$lang" >/dev/null) ]]; then
    info "Adding asdf plugin: ${cyan}$lang${normal}"
    asdf plugin-add $lang

    [[ ! -z $? ]] && return 1
  else
    info "asdf plugin already exists: ${cyan}$lang${normal}"
  fi

  if ! $(asdf list $lang | grep "$version" >/dev/null); then
    info "Installing asdf language: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf install $lang $version

    [[ ! -z $? ]] && return 1
  else
    info "asdf language version already exists: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  if ! $(asdf current $lang | grep "$version" >/dev/null); then
    info "Setting asdf global: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf global $lang $version

    [[ ! -z $? ]] && return 1
  else
    info "asdf gloabl version already set: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  asdf reshim $lang $version

  [[ ! -z $? ]] && return 1
}


# display help if no arguments
if (($# == 0)); then
  print_help_abort
fi

while getopts 'hAYNVbefknptz' flag; do
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


# array of simple files in home folder
files=()

[[ $setup_bash || $all ]] && files+=(.bashrc)
[[ $setup_eslint || $all ]] && files+=(.eslintrc.json)
[[ $setup_tmux || $all ]] && files+=(.tmux.conf)

for filename in ${files[*]}; do
  try_link $this_dir/$filename $HOME/$filename
done

# link neovim files, add neovim python packages, and add edit overrides
function setup_neovim() {
  nvim_dir=$HOME/.config/nvim
  mkdir -p ${nvim_dir}

  try_link $this_dir/init.vim $nvim_dir/init.vim
  try_link $this_dir/coc-settings.json $nvim_dir/coc-settings.json
  try_link $this_dir/UltiSnips $nvim_dir/UltiSnips

  if [[ ! $(type pip3 >/dev/null 2>&1) ]]; then
    echo -e "${red}pip3 not found - python neovim package needed for proper usage${normal}"
    return 1
  fi

  if [[ $(pip3 list 2>/dev/null | grep 'pynvim') ]]; then
    info "Python neovim package already installed"
  else
    info "Installing neovim python3 package - pynvim"
    pip3 install --user pynvim
  fi

  if [[ $(pip3 list 2>/dev/null | grep 'neovim-remote') ]]; then
    info "Python neovim package already installed"
  else
    info "Installing neovim-remote python3 package"
    pip3 install --user neovim-remote
  fi

  info "Clearing editor from git config to use env"
  git config --global --unset core.editor
  # git config --local --unset core.editor

  if [ -n "$(git config --system core.editor)" ]; then
    echo -e "${yellow}WARNING: git system editor set${normal}"
  fi

  if [[ ! -e ~/init.after.vim && ! -L ~/int.after.vim ]]; then
    info "Adding init.after.vim for direct 'edit vim' mapping."
    echo "nnoremap <leader>ev :vsp $this_dir/init.vim<CR>" > ~/init.after.vim
    echo "nnoremap <leader>ez :vsp $this_dir/.zshrc<CR>" >> ~/init.after.vim
  else
    info "${yellow}init.after.vim already exists, not adding direct edit overrides.${normal}"
  fi
}

[[ $setup_neovim || $all ]] && setup_neovim

# clone and install fzf
function setup_fzf() {
  if $(type fzf >/dev/null 2>&1); then
    info "fzf found - not cloning"
    return 0
  fi

  info "Cloning fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  info "Running fzf install"
  $HOME/.fzf/install

  [[ ! -z $? ]] && return 1
}

[[ $setup_fzf || $all ]] && setup_fzf

function clone_prezto() {
  if [[ -e "${ZDOTDIR:-$HOME}/.zprezto"  ]]; then
    info "Prezto already exists - not cloning"
    return 0
  fi

  info "Cloning Prezto"
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

  for filename in ${prezto_files[*]}; do
    try_link $this_dir/$filename $HOME/$filename
  done
}

[[ $setup_prezto || $all ]] && clone_prezto && link_prezto_files

# set zsh as default shell
function set_zsh() {
  if [[ $(echo $SHELL | grep 'zsh') ]]; then
    info "Zsh already default shell"
    return 0
  fi

  if [[ ! $(grep zsh /etc/shells) ]]; then
    echo -e "${red}Zsh not found in /etc/shells${normal}"
    return 1
  fi

  chsh -s $(which zsh)

  [[ ! -z $? ]] && return 1

  # run zsh in current shell
  [[ ! -z $ZSH_NAME ]] && exec zsh
}

[[ $set_zsh || $all ]] && set_zsh
