0=${(%):-%N}

zstyle -s ':zsh_custom:plugin:history-aux:sqlite' histfile 'HISTDBFILE' \
  || HISTDBFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history.db"

zstyle -s ':zsh_custom:plugin:history-aux:json' histfile 'HISTJSFILE' \
  || HISTJSFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history.json"

zmodload zsh/datetime 2>/dev/null
typeset -gA _history_aux_state
if [[ -n "${_history_aux_state[loaded]:-}" ]]; then
  return 0
fi
_history_aux_state[loaded]=1

_history_aux_sqlite_insert() {
  emulate -L zsh
  setopt local_options
  local db="$1"
  shift
  local -a vals=("$@")
  local q="'" i
  for i in {1..$#vals}; do
    vals[i]="'${vals[i]//$q/$q$q}'"
  done
  sqlite3 "$db" \
    "INSERT INTO zsh_history(sid,cwd,cmd,ret,pipestatus,start_ts,end_ts) VALUES(${(j:,:)vals});" \
    >/dev/null 2>&1
}

_history_aux_json_insert() {
  emulate -L zsh
  setopt local_options
  jq -cn \
    --arg     sid        "$2" \
    --arg     cwd        "$3" \
    --arg     cmd        "$4" \
    --argjson ret        "$5" \
    --arg     pipestatus "$6" \
    --argjson start_ts   "$7" \
    --argjson end_ts     "$8" \
    '{sid:$sid,cwd:$cwd,cmd:$cmd,ret:$ret,pipestatus:$pipestatus,start_ts:$start_ts,end_ts:$end_ts}' \
    >> "$1"
}

_history_aux_preexec() {
  local _ignore_space=$options[hist_ignore_space]
  local _reduce_blanks=$options[hist_reduce_blanks]
  emulate -L zsh
  setopt local_options extended_glob

  local cmd="$1"
  [[ -z "$cmd" ]] && return 0
  [[ "$_ignore_space" == on && "$cmd[1]" == ' ' ]] && return 0

  if [[ "$_reduce_blanks" == on ]]; then
    cmd="${${${cmd//[[:blank:]][[:blank:]]##/ }##[[:blank:]]##}%%[[:blank:]]##}"
  fi

  _history_aux_state[cmd]="$cmd"
  _history_aux_state[start_ts]="$EPOCHREALTIME"
}

_history_aux_precmd() {
  local -a _ps=("${pipestatus[@]}")
  local _ignore_dups=$options[hist_ignore_dups]
  local _ignore_all_dups=$options[hist_ignore_all_dups]
  emulate -L zsh
  setopt local_options

  local my_pipestatus="${(j:,:)_ps}"
  local ret="${_ps[-1]}"
  [[ -z "${_history_aux_state[cmd]:-}" ]] && return 0

  local end_ts start_ts cmd cwd sid
  cmd="${_history_aux_state[cmd]}"

  if [[ ( "$_ignore_dups" == on || "$_ignore_all_dups" == on ) \
        && "$cmd" == "${_history_aux_state[last_cmd]:-}" ]]; then
    unset '_history_aux_state[cmd]'
    unset '_history_aux_state[start_ts]'
    return 0
  fi

  end_ts="$EPOCHREALTIME"
  start_ts="${_history_aux_state[start_ts]:-0}"
  cwd="$PWD"
  sid="${_history_aux_state[session]}"

  if zstyle -T ':zsh_custom:plugin:history-aux:sqlite' enable; then
    if [[ "${_history_aux_state[sqlite_init]}" != "$HISTDBFILE" ]]; then
      _history_aux_sqlite_init "$HISTDBFILE" && _history_aux_state[sqlite_init]="$HISTDBFILE"
    fi
    [[ "${_history_aux_state[sqlite_init]}" == "$HISTDBFILE" ]] && \
      _history_aux_sqlite_insert "$HISTDBFILE" "$sid" "$cwd" "$cmd" "$ret" "$my_pipestatus" "$start_ts" "$end_ts" &|
  fi

  if zstyle -T ':zsh_custom:plugin:history-aux:json' enable; then
    if [[ "${_history_aux_state[json_init]}" != "$HISTJSFILE" ]]; then
      _history_aux_json_init "$HISTJSFILE" && _history_aux_state[json_init]="$HISTJSFILE"
    fi
    [[ "${_history_aux_state[json_init]}" == "$HISTJSFILE" ]] && \
      _history_aux_json_insert "$HISTJSFILE" "$sid" "$cwd" "$cmd" "$ret" "$my_pipestatus" "$start_ts" "$end_ts" &|
  fi

  _history_aux_state[last_cmd]="$cmd"
  unset '_history_aux_state[cmd]'
  unset '_history_aux_state[start_ts]'
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _history_aux_preexec
add-zsh-hook precmd _history_aux_precmd

# Run first so pipestatus isn't clobbered by other precmd hooks.
precmd_functions=(_history_aux_precmd ${precmd_functions:#_history_aux_precmd})

_history_aux_sqlite_migration_0() {
  emulate -L zsh
  setopt local_options
  local db="$1"
  sqlite3 "$db" <<'SQL'
CREATE TABLE IF NOT EXISTS zsh_history (
  id         INTEGER PRIMARY KEY,
  sid        TEXT,
  cwd        TEXT,
  cmd        TEXT,
  ret        INTEGER,
  pipestatus TEXT,
  start_ts   REAL,
  end_ts     REAL
);
CREATE INDEX IF NOT EXISTS idx_zsh_history_start_ts ON zsh_history(start_ts DESC);
CREATE INDEX IF NOT EXISTS idx_zsh_history_cmd      ON zsh_history(cmd);
SQL
}

_history_aux_sqlite_init() {
  emulate -L zsh
  setopt local_options
  local db="$1" current_ver i

  mkdir -p "${db:h}" || return 1

  (( $+commands[sqlite3] )) || {
    printf 'history-aux: sqlite3 required for sqlite backend\n' >&2
    return 1
  }

  sqlite3 "$db" "PRAGMA journal_mode=WAL;" >/dev/null 2>&1 || return 1

  current_ver="$(sqlite3 "$db" 'PRAGMA user_version;' 2>/dev/null || echo 0)"

  for i in {0..10}; do
    (( i < current_ver )) && continue
    (( $+functions[_history_aux_sqlite_migration_$i] )) || break
    "_history_aux_sqlite_migration_$i" "$db" || return 1
    sqlite3 "$db" "PRAGMA user_version = $(( i + 1 ));" >/dev/null 2>&1 || return 1
  done
}

_history_aux_json_init() {
  emulate -L zsh
  setopt local_options
  local f="$1"
  mkdir -p "${f:h}" || return 1

  (( $+commands[jq] )) || {
    printf 'history-aux: jq required for json backend\n' >&2
    return 1
  }

  [[ -f "$f" ]] || touch "$f"
}

_history_aux_state[session]="${EPOCHREALTIME}-${RANDOM}-${RANDOM}-${TTY##*/}"

histdb() {
  emulate -L zsh
  local db="${HISTDBFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history.db}"
  [[ -f "$db" ]] || { print "histdb: no database at $db" >&2; return 1 }
  (( $+commands[sqlite3] )) || { print "histdb: sqlite3 not found" >&2; return 1 }

  local -a o_help o_here o_fail o_success o_session o_limit o_reverse
  zparseopts -D -E -- \
    {h,-help}=o_help \
    {d,-here}=o_here \
    {f,-fail}=o_fail \
    {r,-reverse}=o_reverse \
    {s,-success}=o_success \
    {S,-session}=o_session \
    {n,-limit}:=o_limit \
    || { print "usage: histdb [-d] [-f] [-s] [-S] [-r] [-n N] [pattern]" >&2; return 1 }

  if (( $#o_help )); then
    print "usage: histdb [-d] [-f] [-s] [-S] [-r] [-n N] [pattern]" >&2
    return 0
  fi

  local limit=${o_limit[-1]:-50} pattern=${1:-''} order=ASC
  (( $#o_reverse )) && order=DESC
  local -a where

  local q="'"
  (( $#o_here ))    && where+=("cwd = '${PWD//$q/$q$q}'")
  (( $#o_session )) && where+=("sid = '${_history_aux_state[session]//$q/$q$q}'")
  (( $#o_fail ))    && where+=("ret != 0")
  (( $#o_success )) && where+=("ret = 0")
  [[ -n $pattern ]] && where+=("cmd LIKE '%${pattern//$q/$q$q}%'")

  local sql="
    SELECT datetime(start_ts, 'unixepoch', 'localtime') AS time,
           printf('%.2f', end_ts - start_ts)             AS secs,
           ret,
           replace(cwd, '$HOME', '~')                    AS dir,
           cmd
    FROM zsh_history"
  (( $#where )) && sql+=" WHERE ${(j: AND :)where}"
  sql+=" ORDER BY start_ts $order LIMIT $limit;"

  sqlite3 -column -header "$db" "$sql"
}
