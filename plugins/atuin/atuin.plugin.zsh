# Enable atuin integration.
if type atuin >/dev/null 2>&1; then
  # Disable up arrow with --disable-up-arrow.
  # Disabling up arrow means that we need to use C-r for search.
  source <(atuin init zsh)
fi

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:atuin' loaded 'yes'
