#! /bin/bash

# get script's dir
pushd $(dirname $0) > /dev/null
this_dir=$(pwd -P)
popd > /dev/null

shopt -s nocasematch

# try to create a symlink to $1 at $2
function try_link() {
  src_path=$1
  dst_path=$2

  if [[ -e $dst_path || -L $dst_path ]]; then
    echo -e "\033[36m$dst_path\033[0m already exists. \033[31;1mRemove?\033[0m [y/\033[31;1mN\033[0m]"
    read choice
    if [[ ${choice:0:1} == y ]]; then
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

for filename in $files; do
  try_link $this_dir/$filename $HOME/$filename
done

nvim_dir=$HOME/.config/nvim
mkdir -p ${nvim_dir}
try_link $this_dir/init.vim $nvim_dir/init.vim

# if which konsole &> /dev/null; then
if [[ $(which konsole) ]]; then
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

getopts 'p' do_prezto
# prezto setup
if [ $do_prezto ]; then
  # need to set to zsh if not already
  set_zsh=[[ -z $ZSH_NAME ]]

  [ $set_zsh ] && zsh
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  # set zsh as shell
  [ $set_zsh ] && chsh -s /bin/zsh
fi
