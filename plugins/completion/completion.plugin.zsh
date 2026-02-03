#
# completion: Plugin that makes it much easy to initialize Zsh completions.
#

# References:
# - https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Use-of-compinit

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

# Double check we are bootstrapped.
0=${(%):-%N}
zstyle -t ':zsh_custom:lib:__init__' loaded || source ${0:a:h:h:h}/lib/__init__.zsh

# Autoload functions.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

# Define compinit placeholder functions (compdef) so we can queue up calls.
# That way when the real compinit is called, we can execute the queue. Use
# ;;;do compdef;;; to indicate the end of the arg list.
typeset -gHa __compdef_queue=()
function compdef {
  (( $# )) || return
  __compdef_queue+=("${@[@]}" ";;;do compdef;;;")
}

# Wrap compinit temporarily so that when the real compinit call happens, the
# queue of compdef calls is processed.
function compinit {
  unfunction compinit compdef &>/dev/null
  autoload -Uz compinit && compinit "$@"

  # Apply all the queued compdefs.
  local arg; local -a compdef_args=()
  for arg in "${__compdef_queue[@]}"; do
    if [[ "$arg" == ";;;do compdef;;;" ]]; then
      compdef "${compdef_args[@]}"
      compdef_args=()
    else
      compdef_args+=("$arg")
    fi
  done
  unset __compdef_queue
}

# Hook run_compinit
hooks-add-hook postzshrc_hook run_compinit

# Set compstyle
zstyle -s ':zsh_custom:plugin:completion' compstyle _zcompstyle || _zcompstyle=none
if (( $+functions[compstyle_${_zcompstyle}_setup] )); then
  compstyle_${_zcompstyle}_setup
elif [[ $_zcompstyle != (off|none) ]]; then
  echo "completion: compstyle not found '${_zcompstyle}'." >&2
fi
unset _zcompstyle
