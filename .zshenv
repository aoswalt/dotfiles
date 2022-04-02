export DOTFILES=$HOME/.dotfiles

# # arg given to `source` and dropping the filename
# ZPREZTODIR=${0:h}

## Browser
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

typeset -U path fpath cdpath  # prevent duplicates

path=(
  $DOTFILES/scripts
  $HOME/.local/bin
  $path
)

fpath=($DOTFILES/functions $DOTFILES/widgets $fpath)

## Editors
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export MANPAGER='nvim +Man!'
export ELIXIR_EDITOR="nvim +__LINE__ __FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR
export ECTO_EDITOR=$ELIXIR_EDITOR

export PGUSER='postgres'

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob='!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# enable iex history in otp 20
export ERL_AFLAGS="-kernel shell_history enabled"

# include docs for erlang
export KERL_DOC_TARGETS=chunks
export KERL_BUILD_DOCS=yes

# skip nodejs gpg checks with asdf
export NODEJS_CHECK_SIGNATURES=no

# darken lock files
export EXA_COLORS="*.lock=1;30"

# # Set the Less input preprocessor.
# https://github.com/wofr06/lesspipe
# # Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
# if (( $#commands[(i)lesspipe(|.sh)] )); then
#   export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
# fi

## Temporary Files
# Set TMPDIR if the variable is not set/empty or the directory doesn't exist
if [[ -z "${TMPDIR}" ]]; then
  export TMPDIR="/tmp/zsh-${UID}"
fi

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi

## load local zshenv
[ -f $HOME/.zshenv.after ] && source $HOME/.zshenv.after
