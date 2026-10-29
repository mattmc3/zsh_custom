# old: ~/.psqlrc
export PSQLRC=${PSQLRC:-$XDG_CONFIG_HOME/pg/psqlrc}
# old: ~/.pgpass
export PGPASSFILE=${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}
# old: ~/.pg_service.conf
export PGSERVICEFILE=${PGSERVICEFILE:-$XDG_CONFIG_HOME/pg/pg_service.conf}
# old: ~/.psql_history
export PSQL_HISTORY=${PSQL_HISTORY:-$XDG_STATE_HOME/pg/psql_history}
[[ -d ${PSQL_HISTORY:h} ]] || zf_mkdir -p ${PSQL_HISTORY:h}
