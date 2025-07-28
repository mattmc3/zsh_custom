#
# repo - One-time passwords (multi-factor authentication from the command line)
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/repo

! zstyle -t ':zsh_custom:plugin:repo' loaded || return 1

export REPO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/repos"
function repo {
  "$ZSH_CUSTOM/plugins/repo/bin/repo" "$@"
}

# Completions
function __repo_keys {
  local flags
  flags=(
    help -h --help
    home
    ls list
    rm del
    in install
    up update
  )
  local keys
  keys=($(find "$ZSH_REPO_HOME" -type d -name .git 2>/dev/null | while read -r d; do
    repo_path="$(dirname "$d")"
    parent_path="$(dirname "$repo_path")"
    echo "$(basename "$parent_path")/$(basename "$repo_path")"
  done))
  reply=(${flags[@]} ${keys[@]})
}

compctl -K __repo_keys repo

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:repo' loaded 'yes'
