if [[ ! -d "${0:A:h}/pure" ]]; then
  git clone --depth=1 --recursive https://github.com/sindresorhus/pure.git "${0:A:h}/pure"
fi
fpath+="${0:A:h}/pure"

autoload -U promptinit; promptinit
prompt $ZSH_PROMPT
