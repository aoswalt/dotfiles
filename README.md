# Shell Configs

My miscellaneous dotfiles for setting up my shell.

Files are setup by creating symlinks pointing to files in the repo to allow for
easy updating, prompting for overwriting.

Some applications can be installed automatically.

Run `dotfiles` to see a list of the option flags available.

## Dependencies

- asdf `sh $(brew --prefix asdf)/asdf.sh`
- npm packages
  - vim-language-server
  - bash-language-server
  - prettier
  - typescript
  - typescript-language-server
  - vscode-langservers-extracted
- python packages
  - pynvim
  - neovim-remote
- system
  - alacritty
  - tmux
  - yarn
  - git-delta
  - stylua
  - elixir ls
  - ripgrep
  - postgres/psql
  - pgformatter
  - github cli
- mac
  - less
  - gsed
  - coreutils

## Suggestions

- system
  - fzf `$(brew --prefix fzf)/install`
  - zoxide
  - bat
  - exa
  - htop
  - flameshot (brew install flameshot)

---

Submodules are used for some zsh modules, so be sure to include them when cloning and updating!

```sh
git submodule update --init --recursive --remote
```
