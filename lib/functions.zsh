#
# lib/functions: Shared helper functions available to any plugin
#

# Use the base OMZ functions.
source $ZSH/lib/functions.zsh

# Lazy-load (autoload) Zsh function files from a directory.
fpath=($MY_ZSH_CUSTOM/functions $fpath)
autoload -Uz $MY_ZSH_CUSTOM/functions/*(.:t)

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
