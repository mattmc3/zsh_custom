# if homebrew completions exist, use those
if (( $+commands[brew] )); then
  brew_prefix=${commands[brew]:A:h:h}
  fpath=("$brew_prefix"/share/zsh/site-functions(-/FN) $fpath)
  fpath=("$brew_prefix"/opt/curl/share/zsh/site-functions(-/FN) $fpath)
  unset brew_prefix
fi

# use custom completions
fpath=(${ZSH_CUSTOM}/completions(-/FN) $fpath)

fpath+=$ZSH_CUSTOM/.external/zsh-users/zsh-completions/src
source $ZSH_CUSTOM/.external/belak/zsh-utils/completion/completion.plugin.zsh

ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump

compstyle zshzoo
