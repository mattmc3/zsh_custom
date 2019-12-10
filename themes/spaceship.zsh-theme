0=${(%):-%N}
if [[ ! -d "${0:A:h}/spaceship-prompt" ]]; then
  git clone --depth=1 --recursive https://github.com/denysdovhan/spaceship-prompt.git "${0:A:h}/spaceship-prompt"
fi
source ${0:A:h}/spaceship-prompt/spaceship.zsh-theme
