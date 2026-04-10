#
# sqlite
#

export SQLITE_HISTORY="${SQLITE_HISTORY:-${XDG_STATE_HOME:-$HOME/.local/state}/sqlite/history}"
[[ -d ${SQLITE_HISTORY:h} ]] || mkdir -p ${SQLITE_HISTORY:h}
