# Insert 'sudo ' at the beginning of the line with ^X^S
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Insert 'sudo ' at the beginning of the line.
bindkey -M "emacs" "$key_info[Control]X$key_info[Control]S" prepend-sudo
bindkey -M "viins" "$key_info[Control]X$key_info[Control]S" prepend-sudo
