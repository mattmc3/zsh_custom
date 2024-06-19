#
# __init__: zsh_custom helper functions and pre-reqs.
#

# Don't double load.
! zstyle -t ':zsh_custom:plugin:__init__' loaded || return 1

# Set essential options
setopt extended_glob interactive_comments

# Make sure ZSH_CUSTOM is properly set.
: ${ZSH_CUSTOM:=${${(%):-%N}:a:h:h:h}}

# Set core Zsh directories.
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}

##? Ensure directory variables exist.
function mkdirvar {
  local dirvar dirpath
  for dirvar in $@; do
    dirpath=${(P)dirvar}
    if [[ -n "$dirpath" ]] && [[ ! -d $dirpath ]]; then
      echo mkdir -p $dirpath
    fi
  done
}
mkdirvar XDG_{CONFIG,CACHE,DATA,STATE}_HOME __zsh_{config,user_data,cache}_dir

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

function plugin-load {
  : ${REPO_HOME:=${XDG_CACHE_HOME:-$HOME/.cache}/repos}
  : ${ZSH:=$REPO_HOME/ohmyzsh/ohmyzsh}
  : ${ZPREZTODIR:=$REPO_HOME/sorin-ionescu/prezto}

  local plugin inits=()
  for plugin in $@; do
    inits=(
      {$ZSH_CUSTOM,$ZSH}/plugins/$plugin/${plugin}.plugin.zsh(N)
      $ZPREZTODIR/modules/$plugin/init.zsh(N)
      $REPO_HOME/$plugin/${plugin:t}.plugin.zsh(N)
      $REPO_HOME/$plugin/*.{plugin.zsh,zsh,zsh-theme}(N)
    )
    if ! (( $#inits )); then
      print -ru2 "plugin-load: Plugin not found '$plugin'."
      continue
    fi
    source $inits[1]
    zstyle ":zsh_custom:plugin:$plugin" loaded 'yes'
  done
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

# Mark this plugin as loaded.
zstyle ':zsh_custom:plugin:__init__' loaded 'yes'
