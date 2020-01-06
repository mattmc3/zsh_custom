if [[ -z $XDG_CONFIG_HOME ]]; then
  export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
else
  export DOTFILES="${DOTFILES:-$XDG_CONFIG_HOME/dotfiles}"
fi
alias dotf='cd "$DOTFILES" && $VISUAL .'
