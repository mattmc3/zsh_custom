: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}

if ! (( $+commands[zoxide] )); then
  echo >&2 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
  return 1
fi

typeset _initfile=$__zsh_cache_dir/zoxide.init.zsh
typeset -a _cache=($initfile(Nmh-20))
if ! (( $#_cache )); then
  zoxide init zsh 2> /dev/null >| $_initfile
fi
source $_initfile

unset _{cache,initfile}
