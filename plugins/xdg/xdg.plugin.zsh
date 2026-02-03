#
# XDG base dirs - don't pollute home
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME

# aws
if (( $+commands[aws] )); then
  export AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-$XDG_CONFIG_HOME/aws/credentials}"
  export AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-$XDG_CONFIG_HOME/aws/config}"
fi

# bundle (ruby bundler)
if (( $+commands[bundle] )); then
  export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
  export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
  export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}"
fi

# cargo
if (( $+commands[cargo] )); then
  export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
fi

# docker
if (( $+commands[docker] )); then
  export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
fi

# duckdb
if (( $+commands[duckdb] )); then
  export DUCKDB_HISTORY="${DUCKDB_HISTORY:-$XDG_STATE_HOME/duckdb/history}"
  [[ -d ${DUCKDB_HISTORY:h} ]] || mkdir -p ${DUCKDB_HISTORY:h}
fi

# gem (ruby gems)
if (( $+commands[gem] )); then
  export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
  export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"
fi

# go
if (( $+commands[go] )); then
  export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
  export GOMODCACHE="${GOMODCACHE:-$XDG_CACHE_HOME/go/mod}"
fi

# gpg
if (( $+commands[gpg] )); then
  export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
  [[ -e ${GNUPGHOME:h} ]] || mkdir -p ${GNUPGHOME:h}
  alias gpg="${aliases[gpg]:-gpg} --homedir \"\$GNUPGHOME\""
fi

# ipython
if (( $+commands[ipython] )); then
  export IPYTHONDIR="${IPYTHONDIR:-$XDG_CONFIG_HOME/ipython}"
fi

# jupyter
if (( $+commands[jupyter] )); then
  export JUPYTER_CONFIG_DIR="${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}"
fi

# kubectl
if (( $+commands[kubectl] )); then
  export KUBECONFIG="${KUBECONFIG:-$XDG_CONFIG_HOME/kube/config}"
fi

# less
if (( $+commands[less] )); then
  export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
  export LESSHISTFILE="${LESSHISTFILE:-$XDG_STATE_HOME/less/history}"
  [[ -d ${LESSHISTFILE:h} ]] || mkdir -p ${LESSHISTFILE:h}
fi

# mysql
if (( $+commands[mysql] )); then
  export MYSQL_HISTFILE="${MYSQL_HISTFILE:-$XDG_STATE_HOME/mysql/history}"
  [[ -d ${MYSQL_HISTFILE:h} ]] || mkdir -p ${MYSQL_HISTFILE:h}
fi

# npm (node)
if (( $+commands[npm] )); then
  path+=(
    /{opt/homebrew,usr/local}/share/npm/bin(N)
  )
  export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
  export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_STATE_HOME/nodejs/repl_history}"
  [[ -d ${NODE_REPL_HISTORY:h} ]] || mkdir -p ${NODE_REPL_HISTORY:h}
fi

# nuget
if (( $+commands[nuget] || $+commands[dotnet] )); then
  export NUGET_PACKAGES="${NUGET_PACKAGES:-$XDG_CACHE_HOME/NuGetPackages}"
fi

# psql (postgres)
if (( $+commands[psql] )); then
  export PSQLRC="${PSQLRC:-$XDG_CONFIG_HOME/pg/psqlrc}"
  export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_STATE_HOME/pg/psql_history}"
  export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
  export PGSERVICEFILE="${PGSERVICEFILE:-$XDG_CONFIG_HOME/pg/pg_service.conf}"
  [[ -d ${PSQL_HISTORY:h} ]] || mkdir -p ${PSQL_HISTORY:h}
fi

# python3 (matplotlib)
if (( $+commands[python3] )); then
  export MPLCONFIGDIR="${MPLCONFIGDIR:-$XDG_CONFIG_HOME/matplotlib}"
fi

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# redis-cli (redis)
if (( $+commands[redis-cli] )); then
  export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-$XDG_STATE_HOME/redis/history}"
  [[ -d ${REDISCLI_HISTFILE:h} ]] || mkdir -p ${REDISCLI_HISTFILE:h}
fi

# rg (ripgrep)
if (( $+commands[rg] )); then
  export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgrep/config}"
fi

# rustup
if (( $+commands[rustup] )); then
  export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
fi

# screen
if (( $+commands[screen] )); then
  export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"
fi

# sqlite3 (sqlite)
if (( $+commands[sqlite3] )); then
  export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_STATE_HOME/sqlite/history}"
  [[ -d ${SQLITE_HISTORY:h} ]] || mkdir -p ${SQLITE_HISTORY:h}
fi

# tmux
if (( $+commands[tmux] )); then
  export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
  alias tmux="${aliases[tmux]:-tmux} -f \"\$TMUX_CONFIG\""
fi

# wget
if (( $+commands[wget] )); then
  export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
  [[ -d $XDG_CACHE_HOME/wget ]] || mkdir -p $XDG_CACHE_HOME/wget
  alias wget="${aliases[wget]:-wget} --hsts-file=\$XDG_CACHE_HOME/wget/wget-hsts"
fi
