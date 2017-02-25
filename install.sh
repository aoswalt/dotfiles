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
    echo -e "\033[36m$dst_path\033[0m alread exists. \033[31;1mRemove?\033[0m [y\033[32;1mN\033[0m]"
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
files=(".bashrc" ".zshrc" ".tmux.conf" ".eslintrc.json" ".Xresources")
num_files=${#files[@]}

for (( index=0; index<$num_files; ++index )); do
  filename=${files[$index]}
  try_link $this_dir/$filename $HOME/$filename
done

# aliases is a nested file
try_link $this_dir/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh

nvim_dir=$HOME/.config/nvim
mkdir -p "${nvim_dir}"
try_link $this_dir/init.vim $nvim_dir/init.vim

konsole_profile_dir=$HOME/.local/share/konsole
mkdir -p $konsole_profile_dir
try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
