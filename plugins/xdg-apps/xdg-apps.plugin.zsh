#
# XDG base dirs - don't pollute home
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_RUNTIME_DIR

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# app-specific XDG settings, loaded only when the command exists
for _xdg_app in "${0:A:h}/apps"/*.zsh(N); do
  (( $+commands[${_xdg_app:t:r}] )) && source "$_xdg_app"
done
unset _xdg_app
