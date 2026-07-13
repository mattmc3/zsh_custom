# We hijack bzr.zsh to run our custom __init__ in oh-my-zsh.
# As a standalone zsh_custom, there's no need to use this.
[[ -e "${ZSH:-?}"/lib/bzr.zsh ]] || return 0

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:A:h:h}

# Initialize
for _zinit in $MY_ZSH_CUSTOM/init/*.zsh(N); do
  source $_zinit
done
unset _zinit

source $ZSH/lib/bzr.zsh

function autoload-dir {
  local zdir
  local -a zautoloads
  for zdir in "$@"; do
    [[ -d "$zdir" ]] || continue
    fpath=("$zdir" $fpath)
    zautoloads=($zdir/*~_*(N.:t))
    (( $#zautoloads > 0 )) && autoload -Uz $zautoloads
  done
}
