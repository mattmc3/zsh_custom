#
# git-cmds: extra commands for git
#

0=${(%):-%N}
path+=(${0:A:h}/bin)

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:git-cmds' loaded 'yes'
