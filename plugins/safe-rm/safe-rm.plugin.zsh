export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"
if [[ "$OSTYPE" == darwin* ]]; then
  (( ${+commands[trash]} )) || brew install trash
  alias rm="rm.sh"
  alias del="trash -F"
  alias trash="trash -F"
else
  export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"
  alias rm="rm.sh"
  alias del="rm.sh"
  alias trash="rm.sh"
fi
