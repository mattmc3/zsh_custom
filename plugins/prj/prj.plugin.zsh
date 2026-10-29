#
# prj: The project jumper
#

(( $+commands[prj] )) || return 1
cached-eval prj-init-zsh prj -i zsh
