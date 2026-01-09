source $ZSH/lib/history.zsh

# Fix bad settings
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
SAVEHIST=100000
HISTSIZE=20000
