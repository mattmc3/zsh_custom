#
# prj: The project jumper
#

! zstyle -t ':zsh_custom:plugin:prj' loaded || return 1

eval "$("$ZSH_CUSTOM/plugins/prj/bin/prj" -i zsh)"
