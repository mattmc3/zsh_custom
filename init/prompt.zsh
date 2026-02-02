#
# prompt: Set Zsh prompt
#

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

setopt transient_rprompt       # Remove right prompt from prior commands
setopt prompt_subst            # Expand parameters in prompt variables
