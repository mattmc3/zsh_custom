0=${(%):-%N}

# Fish-like abbreviation expansion via zsh global aliases.
# Space expands the last word if it's an alias; Enter expands then accepts.
# Ctrl+Space inserts a literal space without expanding.
# Add words to skip via: zstyle ':zsh_custom:plugin:globalias' noexpand 'word' ...

_globalias_expand_word() {
  local -a noexpand
  zstyle -a ':zsh_custom:plugin:globalias' noexpand 'noexpand' || noexpand=()
  local word=${${(Az)LBUFFER}[-1]}
  [[ $noexpand[(Ie)$word] -eq 0 ]] && zle _expand_alias
}

globalias-space() {
  _globalias_expand_word
  zle self-insert
}
zle -N globalias-space

globalias-accept() {
  _globalias_expand_word
  zle accept-line
}
zle -N globalias-accept

for _ga_keymap in emacs viins; do
  bindkey -M "$_ga_keymap" ' '  globalias-space
  bindkey -M "$_ga_keymap" '^ ' magic-space
  bindkey -M "$_ga_keymap" '^M' globalias-accept
done
bindkey -M isearch ' ' magic-space
unset _ga_keymap
