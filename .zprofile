## Executes commands at login pre-zshrc

## Browser
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

## Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

## Editors
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'


export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# enable iex history in otp 20
export ERL_AFLAGS="-kernel shell_history enabled"

## Paths

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )


# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $HOME/.yarn/bin
  $path
)

## Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

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
