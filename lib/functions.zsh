# Replaces stock lib/functions.zsh, so load it first, then our functions.
# Lib files load before plugins, so plugins can call these.
0=${(%):-%x}
source "$ZSH/lib/functions.zsh"

# Are we running Oh My Zsh?
function is-omz { (( $+functions[omz] )) }

# Platform checks.
function is-bsd    { [[ "$OSTYPE" == *bsd* ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux* ]] }
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

##? Is the name a command, function, alias, or builtin?
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Is the value 1, y, yes, t, true, o, or on (any case)?
function is-true { [[ ${(L)1} == (1|y|yes|t|true|o|on) ]] }

##? Can the function be autoloaded?
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

##? Print the first non-empty argument.
function coalesce {
  local -a vals=($argv)  # unquoted expansion drops empty args
  (( $#vals )) || return 1
  print -r -- "$vals[1]"
}

# Autoload functions
autoload -Uz ${0:A:h:h}/functions/*(N-.:t)
