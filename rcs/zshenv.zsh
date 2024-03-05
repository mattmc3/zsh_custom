#
# .zshenv - Define Zsh environment variables.
#

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# Use .zprofile for remaining environment.
if [[ ! -o LOGIN && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi
