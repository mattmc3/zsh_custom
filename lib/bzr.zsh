# We hijack bzr.zsh to run our custom __init__ in oh-my-zsh.
# As a standalone zsh_custom, there's no need to do that.
[[ -e "${ZSH:-?}"/lib/bzr.zsh ]] || return 0

0=${(%):-%N}
source ${0:a:h}/__init__.zsh
source $ZSH/lib/bzr.zsh
