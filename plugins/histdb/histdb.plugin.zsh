#
# histdb: SQLite history
#

(( $+commands[histdb] )) || return 1
cached-eval histdb-init-zsh histdb init zsh
