#
# compstyle: Set up system for Zsh completion styles similar to prompt system.
#

# References:
# - https://github.com/zsh-users/zsh/blob/master/Functions/Prompts/promptinit


# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

# Lazy-load (autoload) function directory.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

# Mark the plugin as loaded.
zstyle ':zsh_custom:plugin:compstyle' loaded 'yes'
