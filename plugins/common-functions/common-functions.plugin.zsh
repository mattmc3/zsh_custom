#
# common-functions - Zsh functions
#

die()  { warn "$@"; exit "${ERR:-1}"; }
say()  { printf '%s\n' "$@"; }
warn() { say "$@" >&2; }

# Autoload function files in directory
function autoload-dir {
  local zdir
  local -a zautoloads
  for zdir in "$@"; do
    [[ -d "$zdir" ]] || continue
    fpath=("$zdir" $fpath)
    zautoloads=($zdir/*~_*(N.:t))
    (( $#zautoloads > 0 )) && autoload -Uz $zautoloads
  done
}

# Make a directory from a variable name.
function mkdirvar {
  emulate -L zsh
  local zdirvar
  for zdirvar in $@; do
    [[ -d "${(P)zdirvar}" ]] || mkdir -p "$(P){zdirvar}"
  done
}

# Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local cachefile=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}/cached-eval/${cmdname}.zsh
  local -a cached=($cachefile(Nmh-20))
  # If the file has no size (is empty), or is older than 20 hours re-gen the cache.
  if [[ ! -s $cachefile ]] || (( ! ${#cached} )); then
    mkdir -p ${cachefile:h}
    "$@" >| $cachefile
  fi
  source $cachefile
}

# Check if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction "$1"; autoload -U +X "$1" ) &> /dev/null
}

# Check if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Check whether a string represents "true" (1, y, yes, t, true, o, on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

# Check term family.
function is-term-family {
  [[ $TERM = $1 || $TERM = $1-* ]]
}

# Check if tmux.
function is-tmux {
  is-term-family tmux || [[ -n "$TMUX" ]]
}

# Generate a UUID v7 (time-ordered). Result is stored in REPLY.
function gen-uuid7 {
  emulate -L zsh
  zmodload zsh/datetime 2>/dev/null

  local uuid7
  local now sec frac ms ts_hex rand_hex
  local g1 g2 g3 g4 g5

  now="$EPOCHREALTIME"
  sec="${now%%.*}"
  frac="${now#*.}"
  [[ "$frac" == "$now" ]] && frac=0
  frac="${frac}000000"
  ms=$(( 10#${sec} * 1000 + 10#${frac[1,3]} ))
  ts_hex="$(printf '%012x' "$ms")"

  rand_hex=$(od -An -N10 -tx1 /dev/urandom | tr -d ' \n')

  g1="${ts_hex[1,8]}"
  g2="${ts_hex[9,12]}"
  g3="7${rand_hex[1,3]}"
  g4="$(printf '%x' $(( (16#${rand_hex[4]} & 3) | 8 )))${rand_hex[5,7]}"
  g5="${rand_hex[8,19]}"

  typeset -g REPLY="${g1}-${g2}-${g3}-${g4}-${g5}"
  print -- "$REPLY"
}

##? Show all extensions in current folder structure.
function allexts {
  find . -not \( -path '*/.git/*' -prune \) -type f -name '*.*' | sed 's|.*\.|\.|' | sort | uniq -c
}

##? Backup files or directories
function bak {
  local now f
  now=$(date +"%Y%m%d-%H%M%S")
  for f in "$@"; do
    if [[ ! -e "$f" ]]; then
      echo "file not found: $f" >&2
      continue
    fi
    cp -R "$f" "$f".$now.bak
  done
}

##? noext - Find files with no file extension
function noext {
  # for fun, rename with: noext -exec mv '{}' '{}.sql' \;
  find . -not \( -path '*/.git/*' -prune \) -type f ! -name '*.*'
}

##? optdiff - show a diff between set options and Zsh defaults
function optdiff {
  tmp1=$(mktemp)
  tmp2=$(mktemp)
  zsh -df -c "set -o" >| $tmp1
  set -o >| $tmp2
  gdiff --changed-group-format='%<' --unchanged-group-format='' $tmp2 $tmp1
  rm $tmp1 $tmp2
}

##? Remove zwc files
function rmzwc {
  if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "rmzwc"
    echo "  removes zcompiled files"
    echo "options:"
    echo " -q         Quiet"
    echo " --dry-run  Dry run"
    echo " -h --help  Show help screen"
    return 0
  fi

  local findprint="-print"
  local finddel="-delete"
  if [[ "$1" == '-q' ]]; then
    findprint=""
  elif [[ "$1" == "--dry-run" ]]; then
    finddel=""
  fi

  if [[ -d "${ZDOTDIR}" ]]; then
    find "${ZDOTDIR:A}" -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  fi
  find "$HOME" -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  find . -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
}

##? Substitutes string parts with environment variables
function substenv {
  if (( $# == 0 )); then
    subenv ZDOTDIR | subenv HOME
  else
    local sedexp="s|${(P)1}|\$$1|g"
    shift
    sed "$sedexp" "$@"
  fi
}

##? Better tail -f
function tailf {
  local nl
  tail -f $2 | while read j; do
    print -n "$nl$j"
    nl="\n"
  done
}

##? Makes any dirs recursively and then touches a file if it doesn't exist
function touchf {
  if [[ -n "$1" ]] && [[ ! -f "$1" ]]; then
    mkdir -p "$1:h" && touch "$1"
  fi
}

##? What's the weather?
function weather {
  curl "http://wttr.in/$1"
}

##? Compile Zsh files in a directory
function zcompiledir {
  emulate -L zsh; setopt localoptions extendedglob globdots globstarshort nullglob rcquotes
  autoload -U zrecompile

  local f
  local flag_clean=false
  [[ "$1" == "-c" ]] && flag_clean=true && shift
  if [[ -z "$1" ]] || [[ ! -d "$1" ]]; then
    echo "Bad or missing directory $1" && return 1
  fi

  if [[ $flag_clean == true ]]; then
    for f in "$1"/**/*.zwc(.N) "$1"/**/*.zwc.old(.N); do
      echo "removing $f" && command rm -f "$f"
    done
  else
    for f in "$1"/**/*.zsh{,-theme}; do
      echo "compiling $f" && zrecompile -pq "$f"
    done
  fi
}

##? Quickly go up any number of directories.
function up {
  local parents=${1:-1}
  if ! (( "$parents" > 0 )); then
    print -ru2 "up: expecting a numeric parameter"
    return 1
  fi
  local i dotdot=".."
  for ((i = 1 ; i < parents ; i++)); do
    dotdot+="/.."
  done
  cd $dotdot
}

##? Pass thru for copy/paste markdown
function $ { $@ }
