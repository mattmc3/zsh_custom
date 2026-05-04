antibody bundle zsh-users/zsh-completions path:src kind:fpath

autoload -Uz compinit
if (( $+functions[compinit-fast] )); then
  compinit-fast
else
  compinit -i -d "$ZSH_COMPDUMP"
fi
