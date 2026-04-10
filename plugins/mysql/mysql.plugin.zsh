#
# mysql
#

export MYSQL_HISTFILE="${MYSQL_HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/mysql/history}"
[[ -d ${MYSQL_HISTFILE:h} ]] || mkdir -p ${MYSQL_HISTFILE:h}
