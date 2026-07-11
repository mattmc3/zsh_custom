#
# secrets - gpg-encrypted secrets with git-safe storage
#

! zstyle -t ':zsh_custom:plugin:secrets' loaded || return 1

export SECRETS_HOME="${SECRETS_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/secrets}"
function secrets {
  "$MY_ZSH_CUSTOM/plugins/secrets/bin/secrets" "$@"
}

# Completions
function __secrets_args {
  reply=(init home keys add remove status encrypt decrypt rm prune help -C --force)
}

compctl -K __secrets_args secrets
