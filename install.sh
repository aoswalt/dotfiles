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
    # TODO(adam): find appropriate way to handle casing
    if [[ ${choice:0:1} == "y" || ${choice:0:1} == "Y" ]]; then
      rm $dst_path
    fi
  fi

  if ln -s $src_path $dst_path; then
    echo "Link created for $dst_path"
  fi
}

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

if [ -x "$(command -v konsole)" ]; then
  konsole_profile_dir=$HOME/.local/share/konsole
  mkdir -p $konsole_profile_dir
  try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
  try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
fi

# while getopts 'abf:v' flag; do
#   case "${flag}" in
#     a) aflag='true' ;;
#     b) bflag='true' ;;
#     f) files="${OPTARG}" ;;
#     v) verbose='true' ;;
#     *) error "Unexpected option ${flag}" ;;
#   esac
# done

getopts 'p' clone_prezto
# prezto setup
if [ -e $clone_prezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# TODO(adam): set to zsh
