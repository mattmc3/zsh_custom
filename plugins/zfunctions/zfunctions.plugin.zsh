#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

function autoload-dir {
  local zdir
  local -a zautoloads
  for zdir in $@; do
    [[ -n "$zdir" ]] || continue
    if [[ ! -d $zdir ]]; then
      echo >&2 "autoload-dir: Directory not found '$zdir'."
      return 1
    fi
    fpath=("$zdir" $fpath)
    zautoloads=($zdir/*~_*(N.:t))
    (( $#zautoloads > 0 )) && autoload -Uz $zautoloads
  done
}

# Load this plugin's functions.
autoload-dir "${0:a:h}/functions"

# Set ZFUNCDIR.
: ${ZFUNCDIR:=${ZDOTDIR:-$HOME/.config/zsh}/functions}

# Load zfunctions and any subdirs (F-full, N-nullglob, /-dirs).
autoload-dir $ZFUNCDIR(FN/) $ZFUNCDIR/*(FN/)
