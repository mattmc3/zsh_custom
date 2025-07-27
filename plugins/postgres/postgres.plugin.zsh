# Add postgres to our path
path+=(${HOMEBREW_PREFIX:-/opt/homebrew}/opt/postgresql@17/bin(/N))

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:postgres' loaded 'yes'
