#!/bin/zsh
0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

ZSH_THEME="romkatv/powerlevel10k"
zstyle ':zsh_custom:prompt' theme p10k mmc

# Set plugins
plugins=(
  p10k-instaprompt
  repo
  xdg
)

source $MY_ZSH_CUSTOM/zsh_custom.zsh
