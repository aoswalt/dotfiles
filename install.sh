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
  dst_dir=${2-$HOME}
  src_dir=${3-$this_dir}

  src_path=$src_dir/$file
  dst_path=$dst_dir/$file

  if [[ -e $dst_path || -L $dst_path ]]; then
    if [[ $force ]]; then
      choice='y'
    elif [[ ! -z $no_force ]]; then
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

  if [[ -e $dst_path || -L $dst_path ]]; then
    log_error "$dst_path already exists. Cannot create link."
    return 1
  fi

  ln -s $src_path $dst_path

  if [ $? -eq 0 ]; then
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
  if [[ $(command -v asdf) ]]; then
    log_info "asdf already installed"
    return 0
  fi

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3

  [ $? -ne 0 ] && return 1

  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
  log_info "asdf installed"
}

# install the specified language and version with asdf
# TODO: check installed and version
function install_language() {
  lang=$1
  version=$2

  if [[ -z $lang || -z $version ]]; then
    log_error "install_language() requires 2 arguments: language and version"
    return 1
  fi

  if [[ ! $(command -v asdf) ]]; then
    log_error "asdf not found"
    return 1
  fi

  log_info "Setting up asdf ${cyan}$lang${normal} for version ${cyan}$version${normal}"

  if [[ ! $(asdf plugin-list | grep "$lang" >/dev/null 2>&1) ]]; then
    log_info "Adding asdf plugin: ${cyan}$lang${normal}"
    asdf plugin-add $lang

    [ $? -ne 0 ] && return 1
  else
    log_info "asdf plugin already exists: ${cyan}$lang${normal}"
  fi

  # node needs gpg keys added
  if [[ $lang == 'nodejs' ]]; then
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  fi

  if ! $(asdf list $lang | grep "$version" >/dev/null 2>&1); then
    log_info "Installing asdf language: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf install $lang $version

    [ $? -ne 0 ] && return 1
  else
    log_info "asdf language version already exists: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  if ! $(asdf current $lang | grep "$version" >/dev/null 2>&1); then
    log_info "Setting asdf global: ${cyan}$lang${normal} - ${cyan}$version${normal}"
    asdf global $lang $version

    [ $? -ne 0 ] && return 1
  else
    log_info "asdf gloabl version already set: ${cyan}$lang${normal} - ${cyan}$version${normal}"
  fi

  asdf reshim $lang $version

  [ $? -ne 0 ] && return 1
}

# link neovim files, add neovim python packages, and add edit overrides
function setup_neovim() {
  nvim_dir="$HOME/.config/nvim"
  mkdir -p $nvim_dir

  config_files=(
    init.vim
    coc-settings.json
    UltiSnips
  )

  try_link_each config_files $nvim_dir

  if [[ ! $(command -v pip3) ]]; then
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
  if [[ $(command -v fzf) ]]; then
    log_info "fzf found - not cloning"
    return 0
  fi

  log_info "Cloning fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  log_info "Running fzf install"
  $HOME/.fzf/install --all

  [ $? -ne 0 ] && return 1
}

function clone_prezto() {
  if [[ -e "${ZDOTDIR-$HOME}/.zprezto"  ]]; then
    log_info "Prezto already exists - not cloning"
    return 0
  fi

  log_info "Cloning Prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR-$HOME}/.zprezto"
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

  [ $? -ne 0 ] && return 1

  # run zsh in current shell
  [[ ! -z $ZSH_NAME ]] && exec zsh
}

# print help and exit
function print_help() {
  echo '
usage: dotfiles <options>...

  -h, --help          Show help

Settings
  -f, --force         Force setup by answering `yes` to all overwrite prompts
  --no-force          Answer `no` to all prompts
  -v, --verbose       Show info output

Installing
  --all     Install and setup everything

  --files   Link a dotfiles for a tool (bash, neovim, tmux)
  --langs   Install languages with asdf (erlang, elixir, nodejs, postgres, python)
  --lsp     Install language servers (elixir-ls, pyls)
  --tools   Install tools, linking dotfiles as appropriate (eslint, fzf)
  --zsh     Install prezto and set zsh as shell
'
}


# display help if no arguments
if (($# == 0)); then
  print_help
  exit 1
fi

while test "$#" -gt 0; do
  case "$1" in
    -h|--help)
      print_help
      exit 0
      ;;

    -f|--force)   force=1;      shift ;;
    --no-force)   no_force=1;   shift ;;
    -v|--verbose) verbose=1;    shift ;;

    --all)        opt_all=1;    shift ;;
    --files)      opt_files=1;  shift ;;
    --langs)      opt_langs=1;  shift ;;
    --lsp)        opt_lsp=1;    shift ;;
    --tools)      opt_tools=1;  shift ;;
    --zsh)        opt_zsh=1;    shift ;;

    *)
      log_error "Unrecognized option: $1"
      print_help
      exit 1
      ;;
  esac
done


if [[ ${opt_langs-opt_all} ]]; then
  install_asdf
  install_language python 3.7.2
  install_language nodejs 11.10.0
  install_language erlang 21.2.6
  install_language elixir 1.8.1
  install_language postgres 11.2
fi

if [[ ${opt_files-opt_all} ]]; then
  try_link .bashrc
  try_link .eslintrc.json
  try_link .tmux.conf
fi

if [[ ${opt_tools-opt_all} ]]; then
  setup_neovim
  setup_fzf
fi

if [[ ${opt_zsh-opt_all} ]]; then
  clone_prezto && link_prezto_files
  set_zsh
fi

if [[ ${opt_lsp-opt_all} ]]; then
  [[ $(command -v tsserver) ]] || npm i -g typescript
  [[ $(command -v bash-language-server) ]] || npm i -g bash-language-server
  [[ $(command -v dockerfile-language-server-nodejs) ]] || npm i -g dockerfile-language-server-nodejs

  [[ $(command -v elixir-ls) ]] || \
    mkdir -p "$HOME/tools" && \
    cd $_ && \
    git clone https://github.com/JakeBecker/elixir-ls.git && \
    cd elixir-ls && \
    mix do deps.get, elixir_ls.release -o release &&
    ln -s $HOME/tools/elixir-ls/release/language_server.sh /usr/local/bin/elixir-ls

  pip3 install -q python-language-server
fi



# TODO: add selectable options
# Installing
#   --all               Install and setup everything
#   --lang=LANG[,...]   Install a language with asdf (erlang|elixir|nodejs|postgres|python)
#   --tool=TOOL[,...]   Install a tool, linking dotfiles as appropriate (eslint|fzf|prezto)
#   --files=TOOL[,...]  Link a dotfiles for a tool (bash|neovim|tmux)
#   --set=DEFAULT[,...] Set a thing as the default (zsh)


# function match_flag() {
#   while getopts 'hfv' flag "$1"; do
#     case "$flag" in
#       h)
#         print_help
#         exit 0
#         ;;
#       f)
#         force=1
#         ;;
#       v)
#         verbose=1
#         ;;
#       # unneeded because of getopts behavior?
#       # *)
#       #   log_error "Unrecognized flag: $flag"
#       #   exit 1
#       #   ;;
#     esac
#   done
# }


# could abort if some fail
# install_language python 3.7.2 && [ $? -ne 0 ] && exit 1
# install_language nodejs 11.10.0 && [ $? -ne 0 ] && exit 1
