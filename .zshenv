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

## Editors
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export MANPAGER='nvim +Man!'
export ELIXIR_EDITOR="nvim +__LINE__ __FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR
export ECTO_EDITOR="nvim"
# export ECTO_EDITOR=$ELIXIR_EDITOR # pending PR

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# enable iex history in otp 20
export ERL_AFLAGS="-kernel shell_history enabled"

# include docs for erlang
export KERL_DOC_TARGETS=chunks
export KERL_BUILD_DOCS=yes

# darken lock files
export EXA_COLORS="*.lock=1;30"

# Ensure path arrays do not contain duplicates.
# typeset -gU cdpath fpath mailpath path

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
# export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

## Temporary Files
# Set TMPDIR if the variable is not set/empty or the directory doesn't exist
if [[ -z "${TMPDIR}" ]]; then
  export TMPDIR="/tmp/zsh-${UID}"
fi

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi

# fix vim not seeing 256-color terminal
# [[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color && -z "$TMUX" ]] && TERM=xterm-256color
