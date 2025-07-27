#
# iwd: initial working directory
#

: ${IWD:=$PWD}
alias iwd='cd $IWD'

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:iwd' loaded 'yes'
