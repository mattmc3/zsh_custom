#
# abbreviations - expand aliases
#

#
# References
#

# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/globalias/globalias.plugin.zsh
# https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
# https://dev.to/frost/fish-style-abbreviations-in-zsh-40aa

#
# Functions
#

function globalias {
  local -a noexpand_aliases
  zstyle -a ':zsh_custom:plugin:globalias' 'noexpand' 'noexpand_aliases' \
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
zle -N globalias

function globalias-enter {
  local -a noexpand_aliases
  zstyle -a ':zsh_custom:plugin:globalias' 'noexpand' 'noexpand_aliases' \
    || noexpand_aliases=()

  # Check if the whole buffer is an alias
  local cmd="$LBUFFER$RBUFFER"
  if [[ $noexpand_aliases[(Ie)$cmd] -eq 0 ]]; then
    zle _expand_alias
  fi
  zle accept-line
}
zle -N globalias-enter

#
# Keybindings
#

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# RETURN/ENTER expands whole-line alias
bindkey -M emacs "^M" globalias-enter
bindkey -M viins "^M" globalias-enter

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
