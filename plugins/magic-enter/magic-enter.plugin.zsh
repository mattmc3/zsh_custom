#
# magic-enter: Stock plugin with my default commands.
#

: ${MAGIC_ENTER_GIT_COMMAND:='git status -sb'}
: ${MAGIC_ENTER_JJ_COMMAND:='jj st'}
: ${MAGIC_ENTER_OTHER_COMMAND:='ls'}

source $ZSH/plugins/magic-enter/magic-enter.plugin.zsh
