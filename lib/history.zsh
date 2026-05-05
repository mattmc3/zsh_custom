#
# history: Set history
#

if [[ -e "${ZSH:-?}"/lib/history.zsh ]]; then
  source $ZSH/lib/history.zsh
fi

# Fix bad Oh My Zsh defaults
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/zsh_history
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
[[ "$SAVEHIST" -gt 100000 ]] || SAVEHIST=100000
[[ "$HISTSIZE" -gt 50000 ]]  || HISTSIZE=50000
