#
# zoxide: A smarter cd command
#

if ! (( $+commands[zoxide] )); then
  echo >&2 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
  return 1
fi

if (( $+functions[cached-eval] )) && zstyle -T ':zsh_custom:plugin:zoxide' 'use-cache'; then
  cached-eval 'zoxide_init' zoxide init zsh
else
  source <(zoxide init zsh)
fi
