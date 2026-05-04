#
# Setup
#

0=${(%):-%N}
MY_ZSH_CUSTOM="${0:A:h:h}"

#
# Inits
#

source $MY_ZSH_CUSTOM/init/xdg.zsh
source $MY_ZSH_CUSTOM/init/p10k-instaprompt.zsh
source $MY_ZSH_CUSTOM/init/antibody.zsh
source $MY_ZSH_CUSTOM/init/z1.zsh
source $MY_ZSH_CUSTOM/init/hooks.zsh
