#
# magic-enter: add a default command when none is given
#

: ${MAGIC_ENTER_GIT_COMMAND:="git status -sb ."} # run when in a git repository
: ${MAGIC_ENTER_OTHER_COMMAND:="ls -F ."}        # run anywhere else

antibody bundle ohmyzsh/ohmyzsh path:plugins/magic-enter pin:${OMZ_SHA}
