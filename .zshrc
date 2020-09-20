# Source Prezto.
# if file and size > 0
# if [[ -s "$HOME/.zprezto/init.zsh" ]]; then
#   source "$HOME/.zprezto/init.zsh"
# fi

fpath=($DOTFILESDIR/functions $DOTFILESDIR/widgets $fpath)
for zfunction in $DOTFILESDIR/{functions,widgets}/*; do
  autoload -Uz "$zfunction"
done

for zwidget in $DOTFILESDIR/widgets/*; do
  zle -N "${zwidget##*/}"
done

for module in $DOTFILESDIR/modules/*.zsh; do
  source $module
done #2>/dev/null

setopt BEEP                     # Beep on error in line editor.


# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

prompt "rocket"

autoload -Uz zmv

# make ctrl-u delete backwards like bash
bindkey -M emacs \^U backward-kill-line

## functions
mkdwn() { pandoc $1 | lynx -stdin -dump }   # print markdown in terminal

# use nvr to prevent neovim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim=$(echo "No nesting!")
  fi
fi

# case "$OSTYPE" in
#   solaris*) echo "SOLARIS" ;;
#   darwin*)  echo "OSX" ;;
#   linux*)   echo "LINUX" ;;
#   bsd*)     echo "BSD" ;;
#   cygwin*)  echo "WINDOWS (POSIX compat) ;;
#   msys*)    echo "WINDOWS (MinGW)" ;;
#   win32*)   echo "WINDOWS (impossible?)" ;;
#   freebsd*) echo "FREE BSD" ;;
#   *)        echo "unknown: $OSTYPE" ;;
# esac


 # # colorize man pages
 # # https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
# man() {
 #  LESS_TERMCAP_mb=$'\e[1;31m' \
 #  LESS_TERMCAP_md=$'\e[1;31m' \
 #  LESS_TERMCAP_me=$'\e[0m' \
 #  LESS_TERMCAP_se=$'\e[0m' \
 #  LESS_TERMCAP_so=$'\e[1;44;33m' \
 #  LESS_TERMCAP_ue=$'\e[0m' \
 #  LESS_TERMCAP_us=$'\e[1;32m' \
 #  command man "$@"
# }


# Auto Start tmux
# [[ $TERM != screen* ]] && [ -z $TMUX ] && { tmux attach || tmux new-session -s home; }
if [[ $(command -v tmux) && -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$INSIDE_EMACS" && -z "$VSCODE_PID" ]]; then
  tmux start-server

  if ! tmux has-session 2> /dev/null; then
    tmux_session=dev
    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  # Attach to the 'dev' session or to the last session used. (detach first)
  exec tmux attach-session -d
fi


[ $commands[fasd] ] && eval "$(fasd --init auto)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh


fpath=($DOTFILES/external/zsh-completions/src $fpath)
if [ -d ${ASDF_DIR}/completions ]; then
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# initialise completions
autoload -Uz compinit && compinit

# compdef _git gpb=git-checkout

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

source $DOTFILES/external/zsh-you-should-use/you-should-use.plugin.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line cursor root)
source $DOTFILES/external/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $DOTFILES/external/zsh-history-substring-search/zsh-history-substring-search.zsh
source $DOTFILES/external/zsh-autosuggestions/zsh-autosuggestions.zsh

# emacs _should_ be the default keybinds
bindkey -e

## load local zshrc
[ -f $HOME/.zshrc.after ] && source $HOME/.zshrc.after
