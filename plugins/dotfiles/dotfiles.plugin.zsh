if [[ -z $DOTFILES ]]; then
  if [[ -d "$XDG_CONFIG_HOME/dotfiles" ]]; then
    export DOTFILES="$XDG_CONFIG_HOME/dotfiles"
  elif [[ -d "$HOME/.dotfiles" ]]; then
    export DOTFILES="$HOME/.dotfiles"
  fi
fi

if [[ -n $DOTFILES ]]; then
  alias cddotf='cd "$DOTFILES"'
  alias dotf='cd "$DOTFILES" && ${VISUAL:-$EDITOR} .'
fi
