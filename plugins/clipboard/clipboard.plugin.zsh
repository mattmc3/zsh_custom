[[ -d "${ZSH:-?}" ]] || return 1

source $ZSH/lib/clipboard.zsh
source $ZSH/plugins/copyfile/copybuffer.plugin.zsh
source $ZSH/plugins/copyfile/copyfile.plugin.zsh
source $ZSH/plugins/copyfile/copypath.plugin.zsh
