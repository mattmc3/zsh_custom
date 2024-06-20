#
# dotfiles: Helpful aliases for managing dotfiles.
#

export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
export DOTFILES_LOCAL=${DOTFILES_LOCAL:-$HOME/.dotfiles.local}

if zstyle -t ':zsh_custom:plugin:dotfiles' bare; then
  # bare repos
  alias dotf='GIT_WORK_TREE=$HOME GIT_DIR=$DOTFILES'
  alias dotloc='GIT_WORK_TREE=$HOME GIT_DIR=$DOTFILES_LOCAL'
  alias dotty='command git --git-dir=$DOTFILES --work-tree=$HOME'
else
  alias dotf='cd $DOTFILES'
  alias dotfed='cd $DOTFILES && ${VISUAL:-${EDITOR:-vim}} .'
fi
