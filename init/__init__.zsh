#!/bin/zsh

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
if zstyle -T ':zsh_custom:environment' use-xdg-basedirs; then
  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
  export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
  mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME
fi

# Ensure path arrays do not contain duplicates.
typeset -gaU cdpath fpath mailpath path prepath

# Set minimal options
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS

# Set the list of directories that Zsh searches for programs.
[[ -n "$prepath" ]] || prepath=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
)

path=(
  $prepath
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Setup homebrew if it exists on the system.
local -aU brewcmd=(
  $commands[brew](N)
  $HOME/.homebrew/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
)
if (( ${#brewcmd} )); then
  # Default to no tracking.
  HOMEBREW_NO_ANALYTICS="${HOMEBREW_NO_ANALYTICS:-1}"

  # Initialize homebrew.
  source <($brewcmd[1] shellenv)

  # Preserve the desired path order.
  path=($prepath $path)
fi
