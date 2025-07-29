# ZSH_CUSTOM
0=${(%):-%N}
ZSH_CUSTOM="${0:a:h:h}"

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Repos
ZSH_REPO_HOME=$ZSH_CUSTOM/.external
function repo {
  REPO_HOME=$ZSH_REPO_HOME "$ZSH_CUSTOM/plugins/repo/bin/repo" "$@"
}
[[ -d $ZSH_REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt

# OMZ
ZSH=$ZSH_REPO_HOME/ohmyzsh/ohmyzsh

# Set options we always want no matter what.
setopt INTERACTIVE_COMMENTS EXTENDED_GLOB

# Helper functions
source $ZSH_CUSTOM/lib/functions.zsh
