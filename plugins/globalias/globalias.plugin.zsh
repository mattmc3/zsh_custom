0=${(%):-%N}

# Fish-like abbreviation expansion via zsh global aliases.
# Space expands the last word if it's an alias; Enter expands then accepts.
# Alt+Space inserts a literal space without expanding.
# Add words to skip via: zstyle ':zsh_custom:plugin:globalias' noexpand 'word' ...

typeset -gA _globalias_noexpand
() {
  local -a _words
  local _w
  zstyle -a ':zsh_custom:plugin:globalias' noexpand '_words'
  for _w in "${_words[@]}"; do
    _globalias_noexpand[$_w]=1
  done
}

_globalias_expand_word() {
  local word=${${(Az)LBUFFER}[-1]}
  (( $+_globalias_noexpand[$word] )) && return
  (( $+galiases[$word] || ! $+commands[$word] )) && zle _expand_alias
}

globalias-space() {
  _globalias_expand_word
  zle self-insert
}
zle -N globalias-space

# Wrap the accept-line widget rather than binding Enter, so other Enter
# features (magic-enter, accept-line-or-newline) chain instead of clobbering.
if (( ! $+functions[_globalias_accept-line] )); then
  case "$widgets[accept-line]" in
    user:*)
      zle -N _globalias_orig_accept-line "${widgets[accept-line]#user:}"
      _globalias_accept-line() {
        _globalias_expand_word
        zle _globalias_orig_accept-line -- "$@"
      } ;;
    builtin)
      _globalias_accept-line() {
        _globalias_expand_word
        zle .accept-line
      } ;;
  esac
  zle -N accept-line _globalias_accept-line
fi

for _ga_keymap in emacs viins; do
  bindkey -M "$_ga_keymap" ' '  globalias-space
  bindkey -M "$_ga_keymap" '\e ' magic-space
done
bindkey -M isearch ' ' magic-space
unset _ga_keymap
