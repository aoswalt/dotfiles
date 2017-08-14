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
      [ -n $verbose ] && echo "Removing $dst_path"
      rm $dst_path
    fi
  fi

  if [ ! -e $dst_path ] && ln -s $src_path $dst_path; then
    [ -n $verbose ] && echo "Link created for $dst_path"
  fi
}

function print_help_abort() {
  echo 'USAGE: Options'
  exit 0
}


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

if [ -x "$(command -v konsole)" ] && [ -n $konsole_files ]; then
  konsole_profile_dir=$HOME/.local/share/konsole
  mkdir -p $konsole_profile_dir
  try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
  try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
fi

# prezto setup
if [ -n $clone_prezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# TODO(adam): set to zsh
