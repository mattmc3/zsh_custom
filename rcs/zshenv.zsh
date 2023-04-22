#
# .zshenv - Define Zsh environment variables.
#

# This file needs to remain in $HOME, even with $ZDOTDIR set.
# You can symlink it:
# ln -sf ~/.config/zsh/.zshenv ~/.zshenv

#
# XDG base dirs
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

#
# Dotfiles
#

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}
export DOTFILES=~/.config/dotfiles

# Use .zprofile for remaining environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi
