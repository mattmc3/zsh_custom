path+=("$ZSH_REPO_HOME/kaelzhang/shell-safe-rm/bin")
alias rm="rm.sh"
alias del="rm.sh"

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:shell-safe-rm' loaded 'yes'
