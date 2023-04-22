#
# prompt - Set zsh prompt
#

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1

#
# Options
#

setopt PROMPT_SUBST  # Expand parameters in prompt.

#
# Variables
#

# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '

#
# Init
#

# set prompt
fpath+="${0:A:h}/functions"
autoload -Uz promptinit && promptinit

if [[ -n "$ZSH_THEME" ]]; then
  _zsh_theme=$ZSH_THEME
else
  zstyle -s ':zsh_custom:plugin:prompt' theme _zsh_theme || _zsh_theme=starship
fi
prompt $_zsh_theme
unset _zsh_theme
