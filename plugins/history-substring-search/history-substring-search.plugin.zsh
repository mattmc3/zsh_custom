#!/bin/zsh
# https://github.com/zsh-users/zsh-history-substring-search

source "$ZSH_REPO_HOME/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Bind terminal-specific up and down keys
if [[ -n "$terminfo[kcuu1]" ]]; then
  bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
fi
if [[ -n "$terminfo[kcud1]" ]]; then
  bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
  bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
fi

# Vi
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:history-substring-search' loaded 'yes'
