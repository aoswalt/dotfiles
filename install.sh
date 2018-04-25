#! /bin/bash

# get script's directory
this_dir=$(cd $(dirname $0); pwd -P)

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
      read -p $'\033[36m'"$dst_path"$'\033[0m already exists. \033[31;1mRemove?\033[0m [y/\033[31;1mN\033[0m]:  ' choice
    fi

    if [[ $choice =~ ^[Yy] ]]; then
      [[ $verbose ]] && echo -e "Removing \033[36m$dst_path\033[0m"
      rm $dst_path
    else
      [[ $verbose ]] && echo -e "Not removing \033[36m$dst_path\033[0m"
    fi
  fi

  if [[ ! -e $dst_path ]] && ln -s $src_path $dst_path; then
    [[ $verbose ]] && echo -e "Link created for \033[36m$dst_path\033[0m"
  else
    [[ $verbose ]] && echo -e "Could not create link for \033[36m$dst_path\033[0m"
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
-k  konsole   Link Konsole profile and colorscheme
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

while getopts 'hAYNVbefknptz' flag; do
  case "${flag}" in
    h) print_help_abort ;;

    A) all='true' ;;
    Y) all_yes='true' ;;
    N) all_no='true' ;;
    V) verbose='true' ;;

    b) setup_bash='true' ;;
    e) setup_eslint='true' ;;
    f) setup_fzf='true' ;;
    k) konsole_files='true' ;;
    n) setup_neovim='true' ;;
    p) setup_prezto='true' ;;
    t) setup_tmux='true' ;;
    z) set_zsh='true' ;;

    \?) print_help_abort ;;
  esac
done


# array of simple files in home folder
files=()

# TODO(adam): figure out solution for terminal colors
# .Xresources

[[ $setup_bash || $all ]] && files+=(.bashrc)
[[ $setup_eslint || $all ]] && files+=(.eslintrc.json)
[[ $setup_tmux || $all ]] && files+=(.tmux.conf)

[[ $setup_prezto || $all ]] && files+=(
  .zlogin
  .zlogout
  .zpreztorc
  .zprofile
  .zshenv
  .zshrc
)

for filename in ${files[*]}; do
  try_link $this_dir/$filename $HOME/$filename
done

if [[ $setup_neovim || $all ]]; then
  nvim_dir=$HOME/.config/nvim
  mkdir -p ${nvim_dir}
  try_link $this_dir/init.vim $nvim_dir/init.vim
  if $(type pip3 >/dev/null 2>&1); then
    if [[ $(pip3 list 2>/dev/null | grep 'neovim ') ]]; then
      [[ $verbose ]] && echo "Python neovim package already installed"
    else
      [[ $verbose ]] && echo "Installing neovim python3 package"
      pip3 install neovim
    fi

    if [[ $(pip3 list 2>/dev/null | grep 'neovim-remote') ]]; then
      [[ $verbose ]] && echo "Python neovim package already installed"
    else
      [[ $verbose ]] && echo "Installing neovim-remote python3 package"
      pip3 install neovim-remote
    fi

    [[ $verbose ]] && echo "Clearing editor from git config to use env"
    git config --global --unset core.editor
    # git config --local --unset core.editor

    if [ -n "$(git config --system core.editor)" ]; then
      echo 'WARNING: git system editor set'
    fi


    if [[ ! -e ~/init.after.vim && ! -L ~/int.after.vim ]]; then
      [[ $verbose ]] && echo "Adding init.after.vim for direct 'edit vim' mapping."
      echo "nnoremap <leader>ev :vsp $this_dir/init.vim<CR>" > ~/init.after.vim
      echo "nnoremap <leader>ez :vsp $this_dir/.zshrc<CR>" >> ~/init.after.vim
    else
      [[ $verbose ]] && echo "init.after.vim already exists, not adding direct edit overrides."
    fi

  else
    "pip3 not found - python neovim package needed for proper usage"
  fi
fi

if [[ $setup_fzf || $all ]]; then
  if $(type fzf >/dev/null 2>&1); then
    [[ $verbose ]] && echo "fzf found - not cloning"
  else
    [[ $verbose ]] && echo "Cloning fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    [[ $verbose ]] && echo "Running fzf install"
    $HOME/.fzf/install
  fi
fi

if $(type konsole >/dev/null 2>&1) && [[ $konsole_files || $all ]]; then
  konsole_profile_dir=$HOME/.local/share/konsole
  mkdir -p $konsole_profile_dir
  try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
  try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
fi

# prezto setup
if [[ $setup_prezto || $all ]]; then
  if [[ ! -e "${ZDOTDIR:-$HOME}/.zprezto"  ]]; then
    [[ $verbose ]] && echo "Cloning Prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  else
    [[ $verbose ]] && echo "Prezto already exists - not cloning"
  fi
fi

if [[ $set_zsh || $all ]]; then
  if [[ $(echo $SHELL | grep 'zsh') ]]; then
    [[ $verbose ]] && echo "Zsh already default shell"
  else
    # TODO(adam): grep in /etc/shells for zsh
    chsh -s $(which zsh)

    # run zsh in current shell
    [[ ! -z $ZSH_NAME ]] && exec zsh
  fi
fi
