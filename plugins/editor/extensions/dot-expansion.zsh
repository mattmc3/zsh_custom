# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-directory-path

# Expand .... to ../..
bindkey -M "emacs" "." expand-dot-to-parent-directory-path
bindkey -M "viins" "." expand-dot-to-parent-directory-path

# Do not expand .... to ../.. during incremental search.
bindkey -M isearch . self-insert 2> /dev/null
