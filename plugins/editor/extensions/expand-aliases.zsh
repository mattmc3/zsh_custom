# Expand aliases
function expand-aliases {
  zle _expand_alias
  zle expand-word
  zle magic-space
}
zle -N expand-aliases

# control-space expands all aliases, including global
bindkey -M "$keymap" "$key_info[Control] " expand-aliases
