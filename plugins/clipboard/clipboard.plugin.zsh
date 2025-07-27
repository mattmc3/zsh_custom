[[ -d "${ZSH:-?}" ]] || return 1

source $ZSH/lib/clipboard.zsh
source $ZSH/plugins/copybuffer/copybuffer.plugin.zsh
source $ZSH/plugins/copyfile/copyfile.plugin.zsh
source $ZSH/plugins/copypath/copypath.plugin.zsh

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:clipboard' loaded 'yes'
