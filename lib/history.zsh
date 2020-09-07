# source the original, then do overrides
HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"
source "$ZSH"/lib/history.zsh

# you can set $SAVEHIST and $HISTSIZE to anything greater than 1000 and 2000
# respectively, but if not we'll set the values to 5000 and 10000.
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/history
[[ -f "$HISTFILE" ]] || { mkdir -p $(dirname "$HISTFILE") && touch $HISTFILE }
if [[ ! -L "${ZDOTDIR:-$HOME}"/.zsh_history ]]; then
  ln -sf "$HISTFILE" "${ZDOTDIR:-$HOME}"/.zsh_history
fi
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=5000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=10000

