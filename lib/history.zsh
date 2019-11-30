# source the original, then do overrides
HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"
source "$ZSH"/lib/history.zsh

if [[ -z $HISTFILE ]]; then
  if [[ -n "$XDG_DATA_HOME" ]]; then
    HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zhistory"
    [[ -f "$HISTFILE" ]] || { mkdir -p $(dirname "$HISTFILE") && touch $HISTFILE }
  else
    HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
  fi
fi
HISTSIZE=50000
SAVEHIST=10000
