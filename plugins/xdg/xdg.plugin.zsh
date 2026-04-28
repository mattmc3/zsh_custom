#
# XDG base dirs - don't pollute home
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME

# less
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_STATE_HOME/less/history}"
[[ -d ${LESSHISTFILE:h} ]] || mkdir -p ${LESSHISTFILE:h}

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# screen
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
[[ -d $XDG_CACHE_HOME/wget ]] || mkdir -p $XDG_CACHE_HOME/wget
alias wget="${aliases[wget]:-wget} --hsts-file=$XDG_CACHE_HOME/wget/wget-hsts"

# app-specific XDG settings, loaded only when the command exists
for _xdg_app in "${0:A:h}/apps"/*.zsh(N); do
  (( $+commands[${_xdg_app:t:r}] )) && source "$_xdg_app"
done
unset _xdg_app
