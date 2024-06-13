#
# prompt - Set zsh prompt.
#

#
# Variables
#

# Set 2 space indent for each new level in a multi-line script
# This can then be overridden by a prompt, but is a better default than zsh's
PS2='${${${(%):-%_}//[^ ]}// /  }    '

#
# Options
#

# Remove right prompt for prior commands.
setopt transient_rprompt

#
# Functions
#

# Add prompt functions to fpath.
0=${(%):-%N}
fpath=(${0:A:h}/functions $fpath)

# Initialize Zsh's prompt system
autoload -Uz promptinit && promptinit

#
# Init
#

# Set the prompt if specified
local -a prompt_theme
zstyle -a ':mattmc3:zsh_custom:plugin:prompt' theme 'prompt_theme'
if [[ $TERM == (dumb|linux|*bsd*) ]]; then
  prompt 'off'
elif (( $#prompt_theme > 0 )); then
  prompt "$prompt_theme[@]"
fi
unset prompt_theme
