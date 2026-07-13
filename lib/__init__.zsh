#
# __init__: Init stuff that needs to run first
#

# Initialize
0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h:h}

# Lazy-load (autoload) Zsh function files from a directory.
fpath=($MY_ZSH_CUSTOM/functions $fpath)
autoload -Uz $MY_ZSH_CUSTOM/functions/*(.:t)

# Run this early so we can P10k instant prompt if we need it.
if [[ "$ZSH_THEME" == p10k* ]] || [[ "$ZSH_THEME" == powerlevel10k* ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi
