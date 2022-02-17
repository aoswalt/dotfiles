# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
# WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' -- default

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'         '\C-'
  'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
  'ControlPageUp'   '\e[5;5~'
  'ControlPageDown' '\e[6;5~'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "$terminfo[kf1]"
  'F2'           "$terminfo[kf2]"
  'F3'           "$terminfo[kf3]"
  'F4'           "$terminfo[kf4]"
  'F5'           "$terminfo[kf5]"
  'F6'           "$terminfo[kf6]"
  'F7'           "$terminfo[kf7]"
  'F8'           "$terminfo[kf8]"
  'F9'           "$terminfo[kf9]"
  'F10'          "$terminfo[kf10]"
  'F11'          "$terminfo[kf11]"
  'F12'          "$terminfo[kf12]"
  'Insert'       "$terminfo[kich1]"
  'Home'         "$terminfo[khome]"
  'PageUp'       "$terminfo[kpp]"
  'End'          "$terminfo[kend]"
  'PageDown'     "$terminfo[knp]"
  'Up'           "$terminfo[kcuu1]"
  'Left'         "$terminfo[kcub1]"
  'Down'         "$terminfo[kcud1]"
  'Right'        "$terminfo[kcuf1]"
  'BackTab'      "$terminfo[kcbt]"
)

# want emacs keybinds
bindkey -e

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    key_info[$key]='�'
  fi
done

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs "^x^e" edit-command-line
# bindkey -M emacs "$key_info[Control]x$key_info[Control]e" edit-command-line

# # Match bracket.
# # bindkey -M emacs "$key_info[Control]\]" vi-match-bracket
# bindkey -M emacs "$key_info[Control]X$key_info[Control]]" vi-match-bracket

# bindkey -M emacs "$key_info[Insert]" overwrite-mode
bindkey -M emacs "$key_info[Delete]" delete-char

# expand history on space
bindkey -M emacs ' ' magic-space

# # Expand aliases
# function glob-alias {
#   zle _expand_alias
#   zle expand-word
#   zle magic-space
# }
# zle -N glob-alias

# Expand command name to full path.
for key in "$key_info[Escape]"{E,e}
  bindkey -M emacs "$key" expand-cmd-path

# Duplicate the previous word.
for key in "$key_info[Escape]"{M,m}
  bindkey -M emacs "$key" copy-prev-shell-word

# Use a more flexible push-line.
for key in "$key_info[Control]Q" "$key_info[Escape]"{q,Q}
  bindkey -M emacs "$key" push-line-or-edit

# Bind Shift + Tab to go to the previous menu item.
bindkey -M emacs "$key_info[BackTab]" reverse-menu-complete

# Complete in the middle of word.
bindkey -M emacs "$key_info[Control]I" expand-or-complete

# Expand .... to ../..
# bindkey -M emacs "." expand-dot-to-parent-directory-path

# Display an indicator when completing.
bindkey -M emacs "$key_info[Control]I" expand-or-complete-with-indicator
