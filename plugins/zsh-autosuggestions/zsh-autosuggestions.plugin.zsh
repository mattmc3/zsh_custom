#
# zsh-autosuggestions: Stock plugin with my highlight style, and history
# suggestions that skip commands which don't exist.
#

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
(( $+ZSH_AUTOSUGGEST_STRATEGY )) || ZSH_AUTOSUGGEST_STRATEGY=(valid_history)

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# The stock history strategy, minus lines whose command doesn't run, so a typo
# like `iwdd` is never suggested. Ported from z1.
function _zsh_autosuggest_strategy_valid_history {
  emulate -L zsh
  setopt extended_glob
  local pattern="${(b)1}*"
  [[ -z $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]] ||
    pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"

  typeset -g suggestion=${history[(r)$pattern]}
  [[ -z $suggestion ]] || _autosuggest_command_exists "$suggestion" && return

  # The newest match was a typo, so walk the older ones. Only paid after a miss.
  local -i n
  for n in ${(On)${(k)history[(R)$pattern]}}; do
    suggestion=$history[$n]
    _autosuggest_command_exists "$suggestion" && return
  done
  suggestion=
}

# True when the line's command is something that runs. All lookups, no forks.
function _autosuggest_command_exists {
  emulate -L zsh
  setopt extended_glob
  local word
  for word in ${(z)1}; do
    # Leading assignments, as in `FOO=1 make`, are not the command.
    [[ $word == [[:IDENT:]]##=* ]] && continue
    word=${(Q)word}
    (( $+aliases[$word] || $+functions[$word] || $+builtins[$word] ||
       $+commands[$word] || $reswords[(Ie)$word] )) && return 0
    # A path, or anything that is not a plain word, such as `(`.
    [[ $word == */* ]] && { [[ -x ${word/#\~/$HOME} ]]; return }
    [[ $word == [[:IDENT:]-.+]## ]] || return 0
    return 1
  done
  return 0
}
