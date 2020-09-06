if using-prezto; then
  extend-framework-plugin "history-substring-search"
  return
fi

0=${(%):-%N}
if [[ ! -d "${0:A:h}/external" ]]; then
  git clone --depth=1 --recursive https://github.com/zsh-users/zsh-history-substring-search.git "${0:A:h}/external"
fi
source "${0:A:h}/external/zsh-history-substring-search.plugin.zsh"
