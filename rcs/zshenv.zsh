#
# .zshenv - Define Zsh environment variables.
#

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Set Zsh config dir.
export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# Use .zprofile for remaining environment.
if [[ ! -o LOGIN && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi
