#
# .zshenv - Define Zsh environment variables.
#

# This file needs to remain in $HOME, even with $ZDOTDIR set.
# You can symlink it:
# ln -sf ~/.config/zsh/.zshenv ~/.zshenv

#
# XDG base dirs
#

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME

#
# Dotfiles
#

export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
export DOTFILES="$HOME/.dotfiles"

# Use .zprofile for remaining environment.
if [[ -o interactive && -s "${ZDOTDIR:-$HOME}/.zprofile" && ${ZPROFILE_LOADED:-0} -eq 0 ]]; then
  export ZPROFILE_LOADED=1
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
