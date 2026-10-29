#
# editor: Line editor behavior OMZ doesn't have.
#

[[ "$TERM" != 'dumb' ]] || return 1

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# True when $1 is a command ready to run. Compiling it as a function body is
# the test, so there is no subshell and nothing runs.
function command-is-complete {
  setopt local_options no_err_return no_err_exit
  local f=-editor-command-test

  # An odd number of trailing backslashes continues the line.
  (( ${#${1##*[^\\]}} % 2 )) && return 1

  unfunction -- $f 2>/dev/null
  functions[$f]="$1" 2>/dev/null || return 1
  [[ -v functions[$f] ]]         || return 1
  unfunction -- $f

  # `for x` and `cat <<END` are legal function bodies but unfinished commands.
  # If do/done finishes them, the command was waiting for more.
  functions[$f]="$1"$'\ndo\ndone' 2>/dev/null || return 0
  [[ -v functions[$f] ]]                      || return 0
  unfunction -- $f
  return 1
}

# Enter runs a finished command and opens a new line in an unfinished one, so a
# multi-line command is edited in one buffer rather than at a PS2 prompt.
function accept-line-or-newline {
  if command-is-complete "$PREBUFFER$BUFFER"; then
    zle accept-line
  else
    # self-insert-unmeta so zsh-autosuggestions sees the keypress.
    zle self-insert-unmeta
  fi
}
zle -N accept-line-or-newline

# Toggle a leading '#' on the current line. Workaround for buggy pound-insert
# in emacs mode; vi mode uses the built-in vi-pound-insert.
function pound-toggle {
  if [[ "$BUFFER" = '#'* ]]; then
    [[ $CURSOR != $#BUFFER ]] && (( CURSOR -= 1 ))
    BUFFER="${BUFFER:1}"
  else
    BUFFER="#$BUFFER"
    (( CURSOR += 1 ))
  fi
}
zle -N pound-toggle

for _editor_keymap in emacs viins; do
  bindkey -M $_editor_keymap '^M' accept-line-or-newline
  bindkey -M $_editor_keymap '^J' accept-line-or-newline
done
unset _editor_keymap

bindkey -M emacs '^[;' pound-toggle
bindkey -M vicmd '#' vi-pound-insert

# Alt-s prepends sudo, on top of the sudo plugin's Esc-Esc.
if (( $+widgets[sudo-command-line] )); then
  bindkey -M emacs '^[s' sudo-command-line
  bindkey -M viins '^[s' sudo-command-line
fi
