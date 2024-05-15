
for zfunction in $DOTFILES/{functions,widgets}/*; do
  autoload -Uz "$zfunction"
done

for zwidget in $DOTFILES/widgets/*; do
  zle -N "${zwidget##*/}"
done

for module in $DOTFILES/modules/*.zsh; do
  source $module
done

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

prompt "rocket"

# more feature-rich mv command
autoload -Uz zmv

## functions
mkdwn() { pandoc $1 | lynx -stdin -dump }   # print markdown in terminal

# use nvr to prevent neovim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim='echo "No nesting!"'
  fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ $commands[zoxide] ] && eval "$(zoxide init zsh)"

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh


fpath=($DOTFILES/completions $fpath)
if [ -d ${ASDF_DIR}/completions ]; then
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# initialise completions
# autoload -Uz compinit && compinit
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

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
