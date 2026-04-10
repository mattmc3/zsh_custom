#
# redis
#

export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/redis/history}"
[[ -d ${REDISCLI_HISTFILE:h} ]] || mkdir -p ${REDISCLI_HISTFILE:h}
