export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"
if [[ "$OSTYPE" == darwin* ]]; then
  (( ${+commands[trash]} )) || brew install trash
  function rm {
    if [[ $# -eq 1 ]] && [[ -d "$1" ]]; then
      rm.sh -r "$1"
    else
      rm.sh "$@"
    fi
  }
  alias del="trash -F"
  alias trash="trash -F"
else
  export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"
  alias rm="rm.sh"
  alias del="rm.sh"
  alias trash="rm.sh"
fi
