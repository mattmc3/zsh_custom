# Add postgres to path
path+=(${HOMEBREW_PREFIX:-/opt/homebrew}/opt/postgresql@18/bin(/N))

# postgres
export PSQLRC="${PSQLRC:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc}"
export PSQL_HISTORY="${PSQL_HISTORY:-${XDG_CACHE_HOME:-$HOME/.cache}/pg/psql_history}"
export PGPASSFILE="${PGPASSFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass}"
export PGSERVICEFILE="${PGSERVICEFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf}"
