# if homebrew completions exist, use those
if (( $+commands[brew] )); then
  brew_prefix=${commands[brew]:A:h:h}
  fpath=("$brew_prefix"/share/zsh/site-functions(-/FN) $fpath)
  fpath=("$brew_prefix"/opt/curl/share/zsh/site-functions(-/FN) $fpath)
  unset brew_prefix
fi

fpath+=$ZSH_CUSTOM/.external/zsh-completions/src
source $ZSH_CUSTOM/.external/belak/zsh-utils/completion/completion.plugin.zsh

compstyle zshzoo
