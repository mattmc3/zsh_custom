export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/redis/rediscli_history}"
export REDISCLI_RCFILE="${REDISCLI_RCFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/redis/redisclirc}"
[[ -d ${REDISCLI_HISTFILE:h} ]] || mkdir -p ${REDISCLI_HISTFILE:h}
