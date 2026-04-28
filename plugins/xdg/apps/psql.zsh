export PSQLRC="${PSQLRC:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc}"
export PSQL_HISTORY="${PSQL_HISTORY:-${XDG_STATE_HOME:-$HOME/.local/state}/pg/psql_history}"
export PGPASSFILE="${PGPASSFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass}"
export PGSERVICEFILE="${PGSERVICEFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf}"
[[ -d ${PSQL_HISTORY:h} ]] || mkdir -p ${PSQL_HISTORY:h}
