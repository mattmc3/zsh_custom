#!/bin/zsh
# https://github.com/zsh-users/zsh-autosuggestions

source "$ZSH_REPO_HOME/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Set highlight color, default 'fg=8'.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set key bindings.
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:autosuggestions' loaded 'yes'
