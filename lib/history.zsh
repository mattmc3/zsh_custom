# source the original, then do overrides
HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"
source "$ZSH"/lib/history.zsh

if [[ -n "$XDG_DATA_HOME" ]] && [[ -d "$XDG_DATA_HOME" ]]; then
  HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
  [[ -f "$HISTFILE" ]] || { mkdir -p $(dirname "$HISTFILE") && touch $HISTFILE }
  if [[ "$ZDOTDIR" != "$HOME" ]] && [[ ! -L "$ZDOTDIR"/.zsh_history ]]; then
    ln -sf "$HISTFILE" "$ZDOTDIR"/.zsh_history
  fi
else
  HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
fi
HISTSIZE=50000
SAVEHIST=10000
