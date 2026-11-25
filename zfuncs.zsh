#
# zfuncs - Zsh functions
#

0=${(%):-%x}

##? Show all extensions in current folder structure.
function allexts {
  find . -not \( -path '*/.git/*' -prune \) -type f -name '*.*' | sed 's|.*\.|\.|' | sort | uniq -c
}

##? noext - Find files with no file extension
function noext {
  # for fun, rename with: noext -exec mv '{}' '{}.sql' \;
  find . -not \( -path '*/.git/*' -prune \) -type f ! -name '*.*'
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

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Pass thru for copy/paste markdown
function $ { $@ }

##? Queue a directory to cd to, picked up by the next precmd hook.
function termcd {
  local dir="${1:?termcd: directory required}"
  [[ -d "$dir" ]] || { print -u2 "termcd: not a directory: $dir"; return 1; }
  local f="${XDG_CACHE_HOME:-$HOME/.cache}/termcd/${TTY##*/}"
  mkdir -p "${f:h}"
  printf '%s' "$dir" > "$f"
}

# Lazy-load the function files in zfuncs/.
fpath=(${0:A:h}/zfuncs $fpath)
() { autoload -Uz ${@:#*.md} } ${0:A:h}/zfuncs/*(N-.:t)
