#
# rust
#

# rust vars
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:rust' loaded 'yes'
