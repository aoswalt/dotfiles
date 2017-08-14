#! /bin/sh

# get script's directory
this_dir=$(cd $(dirname $0); pwd -P)

# try to create a symlink to $1 at $2
function try_link() {
  src_path=$1
  dst_path=$2

  if [[ -e $dst_path || -L $dst_path ]]; then
    echo -e "\033[36m$dst_path\033[0m already exists. \033[31;1mRemove?\033[0m [y/\033[31;1mN\033[0m]"
    read choice
    if [[ $choice =~ ^[Yy] ]]; then
      [ $verbose ] && echo "Removing \033[36m$dst_path\033[0m"
      rm $dst_path
    else
      [ $verbose ] && echo "Not removing \033[36m$dst_path\033[0m"
    fi
  fi

  if [ ! -e $dst_path ] && ln -s $src_path $dst_path; then
    [ $verbose ] && echo "Link created for \033[36m$dst_path\033[0m"
  else
    [ $verbose ] && echo "Could not create link for \033[36m$dst_path\033[0m"
  fi
}

# print help and exit
function print_help_abort() {
  echo 'USAGE: Options'
  exit 0
}


# display help if no arguments
if (($# == 0)); then
  print_help_abort
fi


while getopts 'Af:khptvz' flag; do
  case "${flag}" in
    A) all='true' ;;
    h) print_help_abort ;;
    k) konsole_files='true' ;;
    p) clone_prezto='true' ;;
    t) setup_tmux='true' ;;
    v) verbose='true' ;;
    z) set_zsh='true' ;;
    \?) print_help_abort ;;

    f) files="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done


# simple files in home folder
files=(
  .Xresources
  .bashrc
  .eslintrc.json
  .tmux.conf
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

nvim_dir=$HOME/.config/nvim
mkdir -p ${nvim_dir}
try_link $this_dir/init.vim $nvim_dir/init.vim

if [ -x "$(command -v konsole)" ] && [ $konsole_files ]; then
  konsole_profile_dir=$HOME/.local/share/konsole
  mkdir -p $konsole_profile_dir
  try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
  try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
fi

# prezto setup
if [ $setup_prezto ]; then
  if [[ ! -e "${ZDOTDIR:-$HOME}/.zprezto"  ]]; then
    [ $verbose ] && echo "Cloning Prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
fi

# TODO(adam): set to zsh
