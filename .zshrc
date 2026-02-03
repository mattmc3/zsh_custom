#!/bin/zsh
0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

# Set plugins
plugins=(gpg)

source $MY_ZSH_CUSTOM/zsh_custom.zsh
