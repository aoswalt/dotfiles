#! /bin/bash

# get script's dir
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
terminator_dir=$home_dir/.config/terminator
mkdir -p "${terminator_dir}"
ln -s "${this_dir}/terminator-config" "${terminator_dir}/config"

ln -s "${this_dir}/aliases.zsh" "${home_dir}/.oh-my-zsh/custom/aliases.zsh"

# need check because follows symlink otherwise
snippets_dir=$home_dir/.janus/mysnippets
if [ ! -L "${snippets_dir}/snippets" ]; then
  mkdir -p "${snippets_dir}"
  ln -s "${this_dir}/snippets" "${snippets_dir}/snippets"
else
  echo "Snippets folder exists in janus config"
fi
