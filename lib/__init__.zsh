# ZSH_CUSTOM
0=${(%):-%N}
ZSH_CUSTOM="${0:a:h:h}"

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Repos
ZSH_REPO_HOME=$ZSH_CUSTOM/.external
function repo {
  REPO_HOME=$ZSH_REPO_HOME "$ZSH_CUSTOM/plugins/repo/bin/repo" "$@"
}
[[ -d $ZSH_REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt

# OMZ
ZSH=$ZSH_REPO_HOME/ohmyzsh/ohmyzsh

# Set options we always want no matter what.
setopt INTERACTIVE_COMMENTS EXTENDED_GLOB

# Helper function
function zsh_custom {
  emulate -L zsh
  setopt local_options

  local subcmd=$1 plugin_dir plugin loaded
  if [[ "$subcmd" == list ]]; then
    for plugin_dir in $ZSH_CUSTOM/plugins/*(N/); do
      echo ${plugin_dir:t}
    done
  elif [[ "$subcmd" == loaded ]]; then
    for plugin_dir in $ZSH_CUSTOM/plugins/*(N/); do
      plugin=${plugin_dir:t}
      if zstyle -t ":zsh_custom:plugin:${plugin}" "loaded"; then
        loaded=yes
      else
        loaded=no
      fi
      printf '%-25s %s\n' $plugin $loaded
    done
  else
    echo "Unrecognized subcommand '$subcmd'." >&2
    return 1
  fi
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
  local cachefile=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cached-eval/${cmdname}.zsh
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
