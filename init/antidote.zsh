#
# antidote: Fast plugin management
#

typeset -gU fpath path

if zstyle -t ":zsh_custom:antidote" use-antibody; then
  if ! (( $+commands[antibody] )); then
    path=(/opt/homebrew/bin(N) $path)
  fi

  if ! (( $+commands[antibody] )); then
    echo >&2 "__init__: antibody command not found. many plugins will not work."
    return 1
  fi

  source <(antibody init)
  function antidote() {
    antibody "$@"
  }
else
  source $HOME/Projects/mattmc3/antidote/antidote.zsh
  source <(antidote init)
fi
