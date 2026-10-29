#
# history: Set history
#

if [[ -e "${ZSH:-?}"/lib/history.zsh ]]; then
  source $ZSH/lib/history.zsh
fi

# Fix bad Oh-My-Zsh defaults
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/zsh_history
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
[[ "$SAVEHIST" -gt 100000 ]] || SAVEHIST=100000
[[ "$HISTSIZE" -gt 50000 ]]  || HISTSIZE=50000

setopt hist_find_no_dups       # Do not display a previously found event.
setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
setopt NO_hist_beep            # Don't beep when accessing non-existent history.
setopt NO_share_history        # Don't share history between all sessions.
