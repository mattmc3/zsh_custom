#
# prompt: Set Zsh prompt
#

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

setopt transient_rprompt       # Remove right prompt from prior commands
setopt prompt_subst            # Expand parameters in prompt variables

# Set 2 space indent for each new level in a multi-line script. This can then be
# overridden by a prompt or plugin, but is a better default than Zsh's.
PS2='${${${(%):-%_}//[^ ]}// /  }    '

function run-promptinit {
  # Initialize the built-in prompt system.
  autoload -Uz promptinit && promptinit

  # Set the prompt if specified.
  local -a prompt_argv
  zstyle -a ':zsh_custom:prompt' theme 'prompt_argv' \
    || prompt_argv=(starship mmc)
  if [[ $TERM == (dumb|linux|*bsd*) ]]; then
    prompt 'off'
  elif (( $#prompt_argv > 0 )); then
    prompt "$prompt_argv[@]"
  fi
}
run-promptinit
