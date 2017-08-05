#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

[[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color && -z "$TMUX" ]] && TERM=xterm-256color

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Remove completion groups
zstyle -d ':completion:*:matches' group
zstyle -d ':completion:*:options' description
zstyle -d ':completion:*:options' auto-description
zstyle -d ':completion:*:corrections' format
zstyle -d ':completion:*:descriptions' format
zstyle -d ':completion:*:messages' format
zstyle -d ':completion:*:warnings' format
zstyle -d ':completion:*:default' list-prompt
zstyle -d ':completion:*' format
zstyle -d ':completion:*' group-name

# unsetopt CORRECT                      # Disable autocorrect guesses.


# aliases
alias weather="curl wttr.in/Nashville"
alias tree="tree -C"
alias python="python3"
alias pip="pip3"
alias l1='ls -1'
alias ll='ls -alF'
alias la='ls -A'
alias la1='ls -A1'
alias l='ls -CF'
alias gresolve='git diff --name-only | uniq | xargs nvim'
alias gresolvep='gresolve -p'
alias gresolveo='gresolve -O'
alias n='nvim'
alias n.='nvim .'
alias v='nvim'

alias giaa="gia -A"

alias yrd='yarn && yarn run dev'
alias exs='iEx -S mix start'

# functions
function = { echo $(($@))  }
mkdwn() { pandoc $1 | lynx -stdin -dump }   # print markdown in terminal

# environment variables
export EDITOR=nvim
export VISUAL=$EDITOR

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# run setups if exist
if [ $commands[autojump] ]; then # check if autojump is installed
  if [ -f $HOME/.autojump/etc/profile.d/autojump.zsh ]; then # manual user-local installation
    . $HOME/.autojump/etc/profile.d/autojump.zsh
  elif [ -f $HOME/.autojump/share/autojump/autojump.zsh ]; then # another manual user-local installation
    . $HOME/.autojump/share/autojump/autojump.zsh
  elif [ -f $HOME/.nix-profile/etc/profile.d/autojump.zsh ]; then # nix installation
    . $HOME/.nix-profile/etc/profile.d/autojump.zsh
  elif [ -f /usr/share/autojump/autojump.zsh ]; then # debian and ubuntu package
    . /usr/share/autojump/autojump.zsh
  elif [ -f /etc/profile.d/autojump.zsh ]; then # manual installation
    . /etc/profile.d/autojump.zsh
  elif [ -f /etc/profile.d/autojump.sh ]; then # gentoo installation
    . /etc/profile.d/autojump.sh
  elif [ -f /usr/local/share/autojump/autojump.zsh ]; then # freebsd installation
    . /usr/local/share/autojump/autojump.zsh
  elif [ -f /opt/local/etc/profile.d/autojump.zsh ]; then # mac os x with ports
    . /opt/local/etc/profile.d/autojump.zsh
  elif [ $commands[brew] -a -f `brew --prefix`/etc/autojump.sh ]; then # mac os x with brew
    . `brew --prefix`/etc/autojump.sh
  fi
fi


# if [[ "$OSTYPE" == "linux-gnu" ]]; then
#   # ...
# elif [[ "$OSTYPE" == "darwin"* ]]; then
#   # Mac OSX
# elif [[ "$OSTYPE" == "cygwin" ]]; then
#   # POSIX compatibility layer and Linux environment emulation for Windows
# elif [[ "$OSTYPE" == "msys" ]]; then
#   # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
# elif [[ "$OSTYPE" == "win32" ]]; then
#   # I'm not sure this can happen.
# elif [[ "$OSTYPE" == "freebsd"* ]]; then
#   # ...
# else
#   # Unknown.
# fi


# case "$OSTYPE" in
#   solaris*) echo "SOLARIS" ;;
#   darwin*)  echo "OSX" ;;
#   linux*)   echo "LINUX" ;;
#   bsd*)     echo "BSD" ;;
#   msys*)    echo "WINDOWS" ;;
#   *)        echo "unknown: $OSTYPE" ;;
# esac

# uname


# [ $commands[setxkbmap] ] && setxkbmap -option caps:ctrl_modifier
# [ $(which setxkbmap) ] && setxkbmap -option caps:ctrl_modifier
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load local zshrc
[ -e $HOME/.zshrc.after ] && source $HOME/.zshrc.after
