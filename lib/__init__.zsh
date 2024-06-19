#
# __init__: zsh_custom helper functions and pre-reqs.
#

# Don't double load.
! zstyle -t ':zsh_custom:lib' loaded || return 1

# Set essential options
setopt extended_glob interactive_comments

# Make sure ZSH_CUSTOM is properly set.
0=${(%):-%N}
ZSH_CUSTOM=${0:a:h:h}

# Set core Zsh directories.
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}

# Autoload zsh_custom functions
fpath=($ZSH_CUSTOM/functions $fpath)
autoload -Uz autoload-dir && autoload-dir $ZSH_CUSTOM/functions

# Ensure key directory variables exist.
mkdirvar XDG_{CONFIG,CACHE,DATA,STATE}_HOME __zsh_{config,user_data,cache}_dir

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Pass thru for copy/paste markdown
function $ { $@ }

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

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

# Mark this plugin as loaded.
zstyle ':zsh_custom:lib' loaded 'yes'
