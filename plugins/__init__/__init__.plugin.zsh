#
# __init__: Ensure zsh_custom is properly boostrapped.
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Make sure ZSH_CUSTOM is properly set.
0=${(%):-%N}
ZSH_CUSTOM=${0:a:h:h:h}

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Set core Zsh directories.
: ${__zsh_config_dir:=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}}
: ${__zsh_cache_dir:=$XDG_CACHE_HOME/zsh}
: ${__zsh_user_data_dir:=$XDG_DATA_HOME/zsh}

# Ensure core dirs exist.
() {
  local d; for d in $@; [[ -d ${(P)_d} ]] || mkdir -p ${(P)_d}
} XDG_{CONFIG,CACHE,DATA,STATE}_HOME __zsh_{config,user_data,cache}_dir

# Set essential options
setopt extended_glob interactive_comments

#region Define shared helper functions

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Autoload function files in directory
function autoload-dir {
  local zdir
  local -a zautoloads
  for zdir in $@; do
    [[ -d "$zdir" ]] || continue
    fpath=("$zdir" $fpath)
    zautoloads=($zdir/*~_*(N.:t))
    (( $#zautoloads > 0 )) && autoload -Uz $zautoloads
  done
}

##? Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local cachefile=$__zsh_cache_dir/cached-eval/${cmdname}.zsh
  local -a cached=($cachefile(Nmh-20))
  # If the file has no size (is empty), or is older than 20 hours re-gen the cache.
  if [[ ! -s $cachefile ]] || (( ! ${#cached} )); then
    mkdir -p ${cachefile:h}
    "$@" > $cachefile
  fi
  source $cachefile
}

##? Check if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

##? Check if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Check a string for case-insensitive "true" value (1,y,yes,t,true,o,on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

##? Pass thru for copy/paste markdown
function $ { $@ }

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

#endregion

# Mark this plugin as loaded.
zstyle ':zsh_custom:plugin:__init__' loaded 'yes'
