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

# Helper function
function zsh_custom {
  emulate -L zsh
  setopt local_options

  local subcmd=$1 plugin_dir plugin loaded
  if [[ "$subcmd" == list ]]; then
    for plugin_dir in $ZSH_CUSTOM/plugins/*(N/); do
      echo ${plugin_dir:t}
    done
  elif [[ "$subcmd" == loaded ]]; then
    for plugin_dir in $ZSH_CUSTOM/plugins/*(N/); do
      plugin=${plugin_dir:t}
      if zstyle -t ":zsh_custom:plugin:${plugin}" "loaded"; then
        loaded=yes
      else
        loaded=no
      fi
      printf '%-25s %s\n' $plugin $loaded
    done
  else
    echo "Unrecognized subcommand '$subcmd'." >&2
    return 1
  fi
}
