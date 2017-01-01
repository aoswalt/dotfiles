#! /bin/bash

# get script's dir
pushd $(dirname $0) > /dev/null
this_dir=$(pwd -P)
popd > /dev/null

home_dir=$(echo $HOME)

# simple files
files=(".bashrc" ".vimrc.after" ".vimrc.before" ".zshrc" ".tmux.conf" ".eslintrc.json")
num_files=${#files[@]}

for (( index=0; index<${num_files}; ++index )); do
  ln -s $this_dir/${files[$index]} $home_dir/${files[$index]}
done

# special case files
# need check because follows symlink otherwise
tmux_dir=$home_dir/.tmux
if [ ! -L "${tmux_dir}" ]; then
  ln -s "${this_dir}/.tmux" "${tmux_dir}"
else
  echo "Tmux folder already exits"
fi

ln -s "${this_dir}/aliases.zsh" "${home_dir}/.oh-my-zsh/custom/aliases.zsh"

# need check because follows symlink otherwise
snippets_dir=$home_dir/.janus/mysnippets
if [ ! -L "${snippets_dir}/snippets" ]; then
  mkdir -p "${snippets_dir}"
  ln -s "${this_dir}/snippets" "${snippets_dir}/snippets"
else
  echo "Snippets folder exists in janus config"
fi

# clone needed repos
if [ ! -d "${home_dir}/.janus/onedark" ]; then
  git clone git@github.com:aoswalt/onedark.vim.git $home_dir/.janus/onedark
else
  echo "onedark folder exists"
fi

nvim_dir=$home_dir/.config/nvim
if [ ! -d "${nvim_dir}" ]; then
  mkdir -p "${nvim_dir}"
fi
ln -s "${this_dir}/init.vim" "${nvim_dir}/init.vim"
