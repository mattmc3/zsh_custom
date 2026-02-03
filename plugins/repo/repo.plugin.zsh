#
# repo: Manage git repositories for Zsh plugins
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/repo

function repo {
  REPO_HOME=$ZSH_REPO_HOME zsh "$MY_ZSH_CUSTOM/bin/repo" "$@"
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
