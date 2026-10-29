#!/usr/bin/env zsh

typeset -gUa path fpath prepath cdpath

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}

# Apps
export EDITOR=nvim
export VISUAL=code
export PAGER=less
export BROWSER=open
export LANG=${LANG:-en_US.UTF-8}
export LESS='-g -i -M -R -S -w -z-4'
export KEYTIMEOUT=1
export SHELL_SESSIONS_DISABLE=1

# Homebrew
if [[ -z "$HOMEBREW_PREFIX" && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Hook lesspipe(.sh) into less so it can handle non-text formats.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Set the path elements that should always be first
prepath=(
  $HOME/bin(N)
  /opt/homebrew/bin(N)
  $HOME/.local/bin(N)
)
path=( $prepath $path )

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
  $XDG_PROJECTS_DIR/mattmc3(N/)
  $cdpath
)
