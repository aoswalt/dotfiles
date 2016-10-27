#! /bin/bash

# get script's path
pushd $(dirname $0) > /dev/null
this_dir=$(pwd -P)
popd > /dev/null

home_dir=$(echo $HOME)

# simple files
files=(".bashrc" ".vimrc.after" ".vimrc.before" ".zshrc")
num_files=${#files[@]}

for (( index=0; index<${num_files}; ++index )); do
  ln -s $this_dir/${files[$index]} $home_dir/${files[$index]}
done

# special case files
terminator_path=$home_dir/.config/terminator
mkdir -p "${terminator_path}"
ln -s "${this_dir}/terminator-config" "${terminator_path}/config"

ln -s "${this_dir}/aliases.zsh" "${home_dir}/.oh-my-zsh/custom/aliases.zsh"
