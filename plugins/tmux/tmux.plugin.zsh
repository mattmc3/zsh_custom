#
# tmux
#

export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
alias tmux="${aliases[tmux]:-tmux} -f \"\$TMUX_CONFIG\""

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:tmux' loaded 'yes'
