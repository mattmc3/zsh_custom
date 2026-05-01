#
# Requirements
#

! zstyle -t ":zsh_custom:plugin:__init__" loaded || return 1

if ! (( $+commands[antibody] )); then
  echo >&2 "__init__: antibody command not found"
  return 1
fi

#
# Init
#

source <(antibody init)
antibody bundle mattmc3/zshrc1

#
# Wrap up
#

zstyle ":zsh_custom:plugin:__init__" loaded yes
