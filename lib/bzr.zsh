# We hijack bzr.zsh to run our custom __init__ in oh-my-zsh, since OMZ only
# loads custom lib files that share a stock lib's name.
[[ -e "${ZSH:-?}"/lib/bzr.zsh ]] || return 0

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:A:h:h}

# Initialize
source $MY_ZSH_CUSTOM/lib/__init__.zsh

# Load OMZ's bzr now.
source $ZSH/lib/bzr.zsh
