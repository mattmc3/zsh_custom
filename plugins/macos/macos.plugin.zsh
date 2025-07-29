#
# macos: Functionality for macOS users.
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/osx

# Return if requirements are not met.
[[ "$OSTYPE" == darwin* ]] || return 1

# Load plugin functions.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

# Mark the plugin as loaded.
zstyle ':zsh_custom:plugin:macos' loaded 'yes'
