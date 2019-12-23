0=${(%):-%N}
if [[ ! -d "${0:A:h}/lean" ]]; then
  git clone --depth=1 --recursive https://github.com/sindresorhus/pure.git "${0:A:h}/pure"
fi
source "${0:A:h}/lean/prompt_pure_setup"
fpath+=("${0:A:h}/pure")
