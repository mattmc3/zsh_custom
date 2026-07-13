# We hijack bzr.zsh to run our custom __init__ in oh-my-zsh.
# As a standalone zsh_custom, there's no need to use this.
[[ -e "${ZSH:-?}"/lib/bzr.zsh ]] || return 0

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:A:h:h}

# Initialize
source $MY_ZSH_CUSTOM/init/antibody.zsh
source $MY_ZSH_CUSTOM/init/functions.zsh
source $MY_ZSH_CUSTOM/init/hooks.zsh

# Load OMZ's bzr now.
source $ZSH/lib/bzr.zsh
