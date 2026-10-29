# old: ~/.redisclirc
export REDISCLI_RCFILE=${REDISCLI_RCFILE:-$XDG_CONFIG_HOME/redis/redisclirc}
# old: ~/.rediscli_history
export REDISCLI_HISTFILE=${REDISCLI_HISTFILE:-$XDG_DATA_HOME/redis/rediscli_history}
[[ -d ${REDISCLI_HISTFILE:h} ]] || zf_mkdir -p ${REDISCLI_HISTFILE:h}
