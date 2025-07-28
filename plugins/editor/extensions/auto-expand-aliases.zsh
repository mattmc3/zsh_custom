function auto-expand-aliases {
  local -a noexpand_aliases
  zstyle -a ':zsh_custom:plugin:auto-expand-aliases' 'noexpand' 'noexpand_aliases' \
    || noexpand_aliases=()

  # Get last word to the left of the cursor:
  # (A) makes it an array even if there's only one element
  # (z) splits into words using shell parsing
  local word=${${(Az)LBUFFER}[-1]}
  if [[ $noexpand_aliases[(Ie)$word] -eq 0 ]]; then
    zle _expand_alias
    # zle expand-word
  fi
  zle self-insert
}
zle -N auto-expand-aliases

function auto-expand-aliases-enter {
  zle auto-expand-aliases
  zle accept-line
}
zle -N auto-expand-aliases-enter

#
# Keybindings
#

# space expands all aliases, including global
bindkey -M emacs " " auto-expand-aliases
bindkey -M viins " " auto-expand-aliases

# RETURN/ENTER expands whole-line alias
bindkey -M emacs "^M" auto-expand-aliases-enter
bindkey -M viins "^M" auto-expand-aliases-enter

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
