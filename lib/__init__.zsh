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
export REPO_HOME=$ZSH_CUSTOM/.external
function repo { $ZSH_CUSTOM/bin/repo "$@"; }
[[ -d $REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt

# OMZ
ZSH=$REPO_HOME/ohmyzsh/ohmyzsh
