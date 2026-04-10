#
# duckdb
#

export DUCKDB_HISTORY="${DUCKDB_HISTORY:-${XDG_STATE_HOME:-$HOME/.local/state}/duckdb/history}"
[[ -d ${DUCKDB_HISTORY:h} ]] || mkdir -p ${DUCKDB_HISTORY:h}
