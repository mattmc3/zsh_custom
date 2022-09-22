# https://news.ycombinator.com/item?id=32880961
# https://github.com/sindresorhus/trash-cli
# https://github.com/andreafrancia/trash-cli
# http://hasseg.org/trash/
# https://github.com/ali-rantakari/trash

alias rm="echo >&2 'STOP USING rm! Use trash'; rm -i"
if [[ "$OSTYPE" == darwin* ]]; then
  (( ${+commands[trash]} )) || brew install trash
  alias del="trash -F"
  alias trash="trash -F"
else
  export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"
  alias del="rm.sh"
  alias trash="rm.sh"
fi
