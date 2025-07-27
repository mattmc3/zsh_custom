[[ -d "${ZSH:-?}" ]] || return 1

source $ZSH/lib/clipboard.zsh
source $ZSH/plugins/copybuffer/copybuffer.plugin.zsh
source $ZSH/plugins/copyfile/copyfile.plugin.zsh
source $ZSH/plugins/copypath/copypath.plugin.zsh
