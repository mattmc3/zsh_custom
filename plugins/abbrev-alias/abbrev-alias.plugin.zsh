if [[ ! -d "${0:A:h}/external" ]]; then
  git clone --depth=1 --recursive https://github.com/momo-lab/zsh-abbrev-alias.git "${0:A:h}/external"
fi
source "${0:A:h}/external/abbrev-alias.plugin.zsh" || return 1
