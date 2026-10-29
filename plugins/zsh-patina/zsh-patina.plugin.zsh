# zsh-patina: Syntax highlighting as you type. Not cached, per patina's docs.
(( $+commands[zsh-patina] && ! $+functions[zsh-patina] )) || return 0
eval "$(zsh-patina activate)"
